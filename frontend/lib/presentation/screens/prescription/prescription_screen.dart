// clone/frontend/lib/presentation/screens/prescription/prescription_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/prescription_response_model.dart';
import '../../bloc/prescription/prescription_bloc.dart';
import '../../bloc/prescription/prescription_event.dart';
import '../../bloc/prescription/prescription_state.dart';
// Import các file cần thiết cho quảng cáo
import 'package:doctor_ai_app/core/services/rewarded_ad_manager.dart';
import 'package:doctor_ai_app/core/ads/ad_helper.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicalHistoryController = TextEditingController();
  final TextEditingController _additionalNotesController = TextEditingController();

  // Khai báo RewardedAdManager cho màn hình này
  late RewardedAdManager _rewardedAdManager;

  @override
  void initState() {
    super.initState();
    // Khởi tạo RewardedAdManager với Ad Unit ID riêng cho màn hình này
    _rewardedAdManager = RewardedAdManager(adUnitId: AdHelper.prescriptionRewardedAdUnitId);
    _rewardedAdManager.loadRewardedAd(); // Tải quảng cáo ngay khi màn hình được khởi tạo
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _symptomsController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _allergiesController.dispose();
    _medicalHistoryController.dispose();
    _additionalNotesController.dispose();
    _rewardedAdManager.dispose(); // Gọi đúng phương thức dispose của RewardedAdManager
    super.dispose();
  }

  // SỬA LỖI: Tích hợp logic quảng cáo vào hàm _generatePrescription() hiện có
  void _generatePrescription() {
    if (_formKey.currentState!.validate()) {
      _rewardedAdManager.showRewardedAd(
        context: context,
        onAdWatchedReward: () {
          // Callback này được gọi khi người dùng xem xong quảng cáo và nhận thưởng
          _performPrescriptionAnalysis(); // Tiến hành phân tích đơn thuốc
        },
        onAdFailed: () {
          // Callback này được gọi khi quảng cáo không sẵn sàng hoặc hiển thị thất bại
          // SỬA LỖI: THÊM LẠI LOGIC KÍCH HOẠT PHÂN TÍCH ĐƠN THUỐC Ở ĐÂY
          _performPrescriptionAnalysis(); // Vẫn thực hiện phân tích ngay cả khi quảng cáo bị bỏ qua/thất bại
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không thể tải quảng cáo. Đang tiến hành phân tích.')),
          );
        },
      );
    }
  }

  void _performPrescriptionAnalysis() {
    // Đây là logic gốc của bạn để gửi sự kiện Bloc
    final List<String> allergiesList = _allergiesController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final event = GeneratePrescriptionRequested(
      diagnosis: _diagnosisController.text,
      symptoms: _symptomsController.text.isNotEmpty ? _symptomsController.text : null,
      patientAge: int.tryParse(_ageController.text),
      patientWeight: double.tryParse(_weightController.text),
      allergies: allergiesList.isNotEmpty ? allergiesList : null,
      medicalHistory: _medicalHistoryController.text.isNotEmpty ? _medicalHistoryController.text : null,
      additionalNotes: _additionalNotesController.text.isNotEmpty ? _additionalNotesController.text : null,
    );
    context.read<PrescriptionBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kê đơn thuốc'),
      ),
      body: BlocListener<PrescriptionBloc, PrescriptionState>(
        listener: (context, state) {
          if (state is PrescriptionSuccess) {
            // Có thể thêm logic cuộn hoặc thông báo thành công
          } else if (state is PrescriptionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi: ${state.error}')),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Thêm dòng thông báo cảnh báo
              Container(
                padding: const EdgeInsets.all(12.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Chỉ nên sử dụng tính năng này khi đã có chẩn đoán chắc chắn từ bác sĩ hoặc cơ sở y tế.',
                        style: TextStyle(color: Colors.orange.shade800, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              // Kết thúc dòng thông báo cảnh báo

              TextFormField(
                controller: _diagnosisController,
                decoration: const InputDecoration(
                  labelText: 'Chẩn đoán bệnh lý *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập chẩn đoán bệnh lý';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _symptomsController,
                decoration: const InputDecoration(
                  labelText: 'Triệu chứng (nếu có)',
                  hintText: 'Ví dụ: Sốt, ho, đau họng',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Tuổi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cân nặng (kg)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'Dị ứng (cách nhau bởi dấu phẩy)',
                  hintText: 'Ví dụ: Penicillin, hải sản',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _medicalHistoryController,
                decoration: const InputDecoration(
                  labelText: 'Tiền sử bệnh lý (nếu có)',
                  hintText: 'Ví dụ: Tiểu đường, cao huyết áp',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _additionalNotesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Ghi chú bổ sung (nếu có)',
                  hintText: 'Ví dụ: Đã dùng thuốc A không hiệu quả',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<PrescriptionBloc, PrescriptionState>(
                builder: (context, state) {
                  if (state is PrescriptionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: _generatePrescription, // Gọi hàm _generatePrescription đã được bọc quảng cáo
                    child: const Text('KÊ ĐƠN THUỐC'),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              BlocBuilder<PrescriptionBloc, PrescriptionState>(
                builder: (context, state) {
                  if (state is PrescriptionInitial) {
                    return const Center(child: Text('Nhập thông tin để kê đơn thuốc.'));
                  }
                  if (state is PrescriptionSuccess) {
                    return _buildPrescriptionDisplay(state.prescription);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrescriptionDisplay(PrescriptionResponseModel prescription) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tóm tắt đơn thuốc:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(prescription.prescriptionSummary),
        const SizedBox(height: 24),
        Text(
          'Các loại thuốc:',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (prescription.drugs.isEmpty)
          const Text('Không có thuốc nào được kê trong đơn này.'),
        ...prescription.drugs.map((drug) => Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drug.drugName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text('Liều dùng: ${drug.dosage}'),
                Text('Tần suất: ${drug.frequency}'),
                // XÓA LỖI: howToUse không tồn tại trong PrescriptionResponseModel.Drug
                // Text('Cách dùng: ${drug.howToUse}'),
                Text('Thời gian: ${drug.duration}'),
                if (drug.notes != null && drug.notes!.isNotEmpty)
                  Text('Ghi chú: ${drug.notes}'),
                // NEW: Hiển thị giá tham khảo nếu có
                if (drug.estimatedPrice != null && drug.estimatedPrice!.isNotEmpty)
                  Text('Giá tham khảo: ${drug.estimatedPrice}', style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        )).toList(),
        const SizedBox(height: 24),
        if (prescription.generalAdvice != null && prescription.generalAdvice!.isNotEmpty) ...[
          Text(
            'Lời khuyên chung:',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(prescription.generalAdvice!),
          const SizedBox(height: 24),
        ],
        Text(
          prescription.disclaimer,
          style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        // NEW: Hiển thị disclaimer riêng cho giá nếu có
        if (prescription.priceDisclaimer != null && prescription.priceDisclaimer!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              prescription.priceDisclaimer!,
              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12),
            ),
          ),
      ],
    );
  }
}