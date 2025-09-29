// clone/frontend/lib/presentation/screens/symptom_analyzer/symptom_analyzer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/symptom_analyzer/symptom_analyzer_bloc.dart';
import '../../bloc/symptom_analyzer/symptom_analyzer_event.dart';
import '../../bloc/symptom_analyzer/symptom_analyzer_state.dart';
import '../../../data/models/symptom_response_model.dart';
// Import các file cần thiết cho quảng cáo
import 'package:doctor_ai_app/core/services/rewarded_ad_manager.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart';

class SymptomAnalyzerScreen extends StatefulWidget {
  const SymptomAnalyzerScreen({super.key});

  @override
  State<SymptomAnalyzerScreen> createState() => _SymptomAnalyzerScreenState();
}

class _SymptomAnalyzerScreenState extends State<SymptomAnalyzerScreen> {
  // --- GIỮ NGUYÊN TOÀN BỘ LOGIC GỐC CỦA BẠN ---
  final _formKey = GlobalKey<FormState>();
  String? _selectedDepartment;
  final _symptomsController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  final _familyHistoryController = TextEditingController();
  final _medicationsController = TextEditingController();

  final List<String> _departments = [
    'Nội khoa', 'Ngoại khoa', 'Sản phụ khoa', 'Nhi khoa',
    'Da liễu', 'Mắt', 'Tai-Mũi-Họng', 'Răng-Hàm-Mặt', 'Thần kinh', 'Tim mạch', 'Cơ xương khớp'
  ];

  // Khai báo RewardedAdManager cho màn hình này
  late RewardedAdManager _rewardedAdManager;

  @override
  void initState() {
    super.initState();
    // Khởi tạo RewardedAdManager với Ad Unit ID riêng cho màn hình này
    _rewardedAdManager = RewardedAdManager(adUnitId: AdHelper.symptomAnalyzerRewardedAdUnitId);
    _rewardedAdManager.loadRewardedAd(); // Tải quảng cáo ngay khi màn hình được khởi tạo
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    _medicalHistoryController.dispose();
    _familyHistoryController.dispose();
    _medicationsController.dispose();
    _rewardedAdManager.dispose(); // Giải phóng quảng cáo khi màn hình bị dispose
    super.dispose();
  }

  void _submitForm() {
    // Đóng bàn phím
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      // Khi người dùng nhấn nút submit, hiển thị quảng cáo có thưởng
      _rewardedAdManager.showRewardedAd(
        context: context,
        onAdWatchedReward: () {
          // Callback này được gọi khi người dùng xem xong quảng cáo và nhận thưởng
          _performSymptomAnalysis(); // Tiến hành phân tích triệu chứng
        },
        onAdFailed: () {
          // Callback này được gọi khi quảng cáo không sẵn sàng hoặc hiển thị thất bại
          // SỬA LỖI: THÊM LẠI LOGIC KÍCH HOẠT PHÂN TÍCH TRIỆU CHỨNG Ở ĐÂY
          _performSymptomAnalysis(); // Vẫn thực hiện phân tích ngay cả khi quảng cáo bị bỏ qua/thất bại
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không thể tải quảng cáo. Đang tiến hành phân tích.')),
          );
        },
      );
    }
  }

  void _performSymptomAnalysis() {
    // Đây là logic gốc của bạn để gửi sự kiện Bloc
    final event = AnalyzeSymptomsSubmitted(
      symptomsDescription: _symptomsController.text,
      department: _selectedDepartment,
      medicalHistory: _medicalHistoryController.text,
      familyHistory: _familyHistoryController.text,
      currentMedications: _medicationsController.text,
    );
    context.read<SymptomAnalyzerBloc>().add(event);
  }

  // --- PHẦN BUILD GIAO DIỆN ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phân tích Triệu chứng Chi tiết')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // SỬA LẠI CÁCH ÁP DỤNG DECORATION CHO ĐÚNG
            _buildSectionTitle('Thông tin khám'),
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              hint: const Text('Chọn chuyên khoa (nếu biết)'),
              items: _departments.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                });
              },
              // Sửa lại: Để trống decoration, theme sẽ tự áp dụng style
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Mô tả triệu chứng chính *'),
            TextFormField(
              controller: _symptomsController,
              maxLines: 5,
              // Sửa lại: Dùng InputDecoration và truyền hintText vào
              decoration: const InputDecoration(
                hintText: 'Ví dụ: đau đầu, sốt 38 độ, ho khan...',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng mô tả triệu chứng của bạn';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Bệnh sử cá nhân (nếu có)'),
            TextFormField(
              controller: _medicalHistoryController,
              decoration: const InputDecoration(
                hintText: 'Ví dụ: tiểu đường, cao huyết áp...',
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Tiền sử bệnh gia đình (nếu có)'),
            TextFormField(
              controller: _familyHistoryController,
              decoration: const InputDecoration(
                hintText: 'Ví dụ: Bố bị bệnh tim...',
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Thuốc đang sử dụng (nếu có)'),
            TextFormField(
              controller: _medicationsController,
              decoration: const InputDecoration(
                hintText: 'Liệt kê các loại thuốc bạn đang dùng...',
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<SymptomAnalyzerBloc, SymptomAnalyzerState>(
              builder: (context, state) {
                if (state is SymptomAnalyzerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: _submitForm, // Gọi hàm _submitForm để xử lý quảng cáo
                  child: const Text('PHÂN TÍCH'),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SymptomAnalyzerBloc, SymptomAnalyzerState>(
              builder: (context, state) {
                if (state is SymptomAnalyzerInitial) {
                  return const SizedBox.shrink();
                }
                if (state is SymptomAnalyzerFailure) {
                  return Center(
                      child: Text('Lỗi: ${state.error}',
                          style: const TextStyle(color: Colors.red)));
                }
                if (state is SymptomAnalyzerSuccess) {
                  // Giữ nguyên widget hiển thị kết quả đẹp mắt
                  return _buildResultWidget(context, state.result);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
    );
  }

  // === WIDGET HIỂN THỊ KẾT QUẢ GIỮ NGUYÊN NHƯ LẦN TRƯỚC VÌ NÓ ĐÃ ĐÚNG ===
  Widget _buildResultWidget(BuildContext context, SymptomResponseModel result) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services_outlined, color: theme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Gợi ý chuyên khoa:',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (result.recommendedSpecialties.isNotEmpty)
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: result.recommendedSpecialties.map((specialty) {
                  return Chip(
                    label: Text(specialty),
                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w600),
                    side: BorderSide(color: theme.primaryColor.withOpacity(0.2)),
                  );
                }).toList(),
              )
            else
              const Text('Không có gợi ý cụ thể.'),
            
            const Divider(height: 32),

            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  'Thông tin thêm:',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              result.potentialInfo,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),

            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.red, size: 24),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Gợi ý này chỉ mang tính tham khảo và không thể thay thế cho chẩn đoán của bác sĩ. Vui lòng đến cơ sở y tế để được thăm khám.',
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}