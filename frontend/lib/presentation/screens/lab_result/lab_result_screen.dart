import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../bloc/lab_result_analyzer/lab_result_analyzer_bloc.dart';
import '../../bloc/lab_result_analyzer/lab_result_analyzer_event.dart';
import '../../bloc/lab_result_analyzer/lab_result_analyzer_state.dart';
import '../../../data/models/lab_result_response_model.dart';
// Import các file cần thiết cho quảng cáo
import 'package:doctor_ai_app/core/services/rewarded_ad_manager.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart';

class LabResultScreen extends StatefulWidget {
  const LabResultScreen({super.key});

  @override
  State<LabResultScreen> createState() => _LabResultScreenState();
}

class _LabResultScreenState extends State<LabResultScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedTestType; // Thêm biến để lưu loại xét nghiệm

  // Danh sách các loại xét nghiệm gợi ý
  final List<String> _testTypes = [
    'Xét nghiệm máu',
    'Xét nghiệm nước tiểu',
    'Xét nghiệm tổng quát',
    'X-Quang',
    'MRI',
    'CT Scan',
    'Siêu âm',
    'Điện tâm đồ (ECG)',
    'Nội soi',
    'Phân tích đơn thuốc',
    'Khác'
  ];

  // Khai báo RewardedAdManager cho màn hình này
  late RewardedAdManager _rewardedAdManager;

  @override
  void initState() {
    super.initState();
    // Khởi tạo RewardedAdManager với Ad Unit ID riêng cho màn hình này
    _rewardedAdManager = RewardedAdManager(adUnitId: AdHelper.labResultRewardedAdUnitId);
    _rewardedAdManager.loadRewardedAd(); // Tải quảng cáo ngay khi màn hình được khởi tạo
  }

  @override
  void dispose() {
    _rewardedAdManager.dispose(); // Giải phóng quảng cáo khi màn hình bị dispose
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      
      // ĐÃ SỬA LỖI: THÊM `if (!mounted) return;` TRƯỚC KHI GỌI `showRewardedAd`
      // để tránh `BuildContext`s across async gaps.
      if (!mounted) return;

      // Khi ảnh đã được chọn, hiển thị quảng cáo có thưởng
      _rewardedAdManager.showRewardedAd(
        context: context,
        onAdWatchedReward: () {
          // Callback này được gọi khi người dùng xem xong quảng cáo và nhận thưởng
          _performLabResultAnalysis(); // Tiến hành phân tích kết quả xét nghiệm
        },
        onAdFailed: () {
          // Callback này được gọi khi quảng cáo không sẵn sàng hoặc hiển thị thất bại
          _performLabResultAnalysis(); // Vẫn thực hiện phân tích ngay cả khi quảng cáo bị bỏ qua/thất bại
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Không thể tải quảng cáo. Đang tiến hành phân tích.')),
            );
          }
        },
      );
    }
  }

  void _performLabResultAnalysis() {
    if (_image != null) {
      // Gửi sự kiện phân tích khi ảnh được chọn, kèm theo loại xét nghiệm
      context.read<LabResultAnalyzerBloc>().add(
        AnalyzeLabResultImageSubmitted(
          imageFile: _image!,
          testType: _selectedTestType, // Truyền loại xét nghiệm đã chọn
        ),
      );
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ảnh trước khi phân tích.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phân tích kết quả xét nghiệm/X-Ray/Đơn Thuốc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown để chọn loại xét nghiệm
            DropdownButtonFormField<String>(
              value: _selectedTestType,
              hint: const Text('Chọn loại xét nghiệm/tài liệu y tế'),
              items: _testTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTestType = newValue;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Loại xét nghiệm/Tài liệu',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery), // Gọi _pickImage để bao bọc ads
              icon: const Icon(Icons.photo_library),
              label: const Text('Chọn ảnh từ Thư viện'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera), // Gọi _pickImage để bao bọc ads
              icon: const Icon(Icons.camera_alt),
              label: const Text('Chụp ảnh mới'),
            ),
            const SizedBox(height: 24),
            if (_image != null)
              Expanded(
                child: BlocBuilder<LabResultAnalyzerBloc, LabResultAnalyzerState>(
                  builder: (context, state) {
                    if (state is LabResultAnalyzerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is LabResultAnalyzerFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.file(_image!, height: 150),
                            const SizedBox(height: 16),
                            Text('Lỗi: ${state.error}', style: const TextStyle(color: Colors.red)),
                            const Text('Vui lòng thử lại với ảnh rõ nét hơn.'),
                          ],
                        ),
                      );
                    }
                    if (state is LabResultAnalyzerSuccess) {
                      return _buildResultDisplay(state.result);
                    }
                    // Hiển thị ảnh đã chọn khi trạng thái là Initial sau khi chọn ảnh
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.file(_image!, height: 200),
                          const SizedBox(height: 16),
                          Text(
                            _selectedTestType != null
                                ? 'Ảnh ${_selectedTestType!} đã được chọn. Đang chờ phân tích...'
                                : 'Ảnh đã được chọn. Đang chờ phân tích...',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text('Vui lòng chọn hoặc chụp ảnh kết quả xét nghiệm/tài liệu y tế để phân tích.'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDisplay(LabResultResponseModel result) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tóm tắt:',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(result.summary),
          const SizedBox(height: 24),
          if (result.overallInterpretation != null && result.overallInterpretation!.isNotEmpty) ...[
            Text(
              'Diễn giải tổng thể:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(result.overallInterpretation!),
            const SizedBox(height: 24),
          ],
          if (result.abnormalIndicators.isNotEmpty) ...[
            Text(
              'Các chỉ số bất thường:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: result.abnormalIndicators.length,
              itemBuilder: (context, index) {
                final indicator = result.abnormalIndicators[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${indicator.indicatorName}: ${indicator.value} ${indicator.unit}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text('Phạm vi tham chiếu: ${indicator.referenceRange}'),
                        Text('Giải thích: ${indicator.explanation}'),
                        if (indicator.questionsForDoctor.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Text('Câu hỏi cho bác sĩ:', style: TextStyle(fontStyle: FontStyle.italic)),
                          // ĐÃ SỬA LỖI: Sử dụng spread operator ... để mở rộng Iterable thành List<Widget>
                          ...indicator.questionsForDoctor.map((q) => Text('- $q')),
                        ]
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
          if (result.normalIndicators_summary != null && result.normalIndicators_summary!.isNotEmpty) ...[
            Text(
              'Tóm tắt chỉ số bình thường:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(result.normalIndicators_summary!),
            const SizedBox(height: 24),
          ],
          if (result.health_insights != null && result.health_insights!.isNotEmpty) ...[
            Text(
              'Thông tin chuyên sâu về sức khỏe:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(result.health_insights!),
            const SizedBox(height: 24),
          ],
          if (result.recommendations != null && result.recommendations!.isNotEmpty) ...[
            Text(
              'Khuyến nghị:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ĐÃ SỬA LỖI: Sử dụng spread operator ... để mở rộng Iterable thành List<Widget>
              children: result.recommendations!.map((rec) => Text('- $rec')).toList(), // Để List<Widget> rõ ràng
            ),
            const SizedBox(height: 24),
          ],
          const Text(
            'Lưu ý: Kết quả phân tích này chỉ mang tính tham khảo và không thể thay thế cho lời khuyên y tế chuyên nghiệp hoặc chẩn đoán. Vui lòng tham khảo ý kiến bác sĩ.',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}