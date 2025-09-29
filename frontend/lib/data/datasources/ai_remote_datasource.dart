// clone/frontend/lib/data/datasources/ai_remote_datasource.dart

import 'dart:io';
import '../../core/services/api_service.dart';
import '../models/symptom_response_model.dart';
import '../models/lab_result_response_model.dart';
import '../models/chat_response_model.dart';
import '../models/prescription_response_model.dart'; // NEW: Import prescription response model

abstract class AiRemoteDataSource {
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

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final ApiService apiService;

  AiRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ChatResponseModel> getChatResponse(String query) async {
    return await apiService.getChatResponse(query);
  }

  @override
  Future<SymptomResponseModel> analyzeSymptoms(Map<String, dynamic> symptomData) async {
    return await apiService.analyzeSymptoms(symptomData);
  }

  @override
  Future<LabResultResponseModel> analyzeLabResultImage(File imageFile, String? testType) async {
    return await apiService.analyzeLabResultImage(imageFile, testType);
  }

  @override
  Future<Map<String, dynamic>> sendVoiceChat({
    required String audioBase64,
    required String audioFormat,
    required int sampleRateHertz,
    required String languageCode,
  }) async {
    return await apiService.sendVoiceChat(
      audioBase64: audioBase64,
      audioFormat: audioFormat,
      sampleRateHertz: sampleRateHertz,
      languageCode: languageCode,
    );
  }

  // NEW: Triển khai phương thức generatePrescription
  @override
  Future<PrescriptionResponseModel> generatePrescription(Map<String, dynamic> prescriptionData) async {
    return await apiService.generatePrescription(prescriptionData);
  }
}