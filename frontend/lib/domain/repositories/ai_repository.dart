// clone/frontend/lib/domain/repositories/ai_repository.dart

import 'dart:io';
import '../../data/models/symptom_response_model.dart';
import '../../data/models/lab_result_response_model.dart';
import '../../data/models/chat_response_model.dart';
import '../../data/models/prescription_response_model.dart'; // NEW: Import prescription response model

abstract class AiRepository {
  Future<ChatResponseModel> getChatResponse(String query);
  Future<SymptomResponseModel> analyzeSymptoms(Map<String, dynamic> symptomData);
  Future<LabResultResponseModel> analyzeLabResultImage(File imageFile, String? testType);

  Future<Map<String, dynamic>> sendVoiceChat({
    required String audioBase64,
    required String audioFormat,
    required int sampleRateHertz,
    required String languageCode,
  });

  // NEW: Phương thức để tạo đơn thuốc
  Future<PrescriptionResponseModel> generatePrescription(Map<String, dynamic> prescriptionData);
}