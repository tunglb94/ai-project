// clone/frontend/lib/data/repositories/ai_repository_impl.dart

import 'dart:io';
import '../../data/models/symptom_response_model.dart';
import '../../data/models/lab_result_response_model.dart';
import '../../data/models/chat_response_model.dart';
import '../../data/models/prescription_response_model.dart'; // NEW: Import prescription response model
import '../../domain/repositories/ai_repository.dart';
import '../datasources/ai_remote_datasource.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource remoteDataSource;

  AiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ChatResponseModel> getChatResponse(String query) async {
    return await remoteDataSource.getChatResponse(query);
  }

  @override
  Future<SymptomResponseModel> analyzeSymptoms(Map<String, dynamic> symptomData) async {
    return await remoteDataSource.analyzeSymptoms(symptomData);
  }

  @override
  Future<LabResultResponseModel> analyzeLabResultImage(File imageFile, String? testType) async {
    return await remoteDataSource.analyzeLabResultImage(imageFile, testType);
  }

  @override
  Future<Map<String, dynamic>> sendVoiceChat({
    required String audioBase64,
    required String audioFormat,
    required int sampleRateHertz,
    required String languageCode,
  }) async {
    return await remoteDataSource.sendVoiceChat(
      audioBase64: audioBase64,
      audioFormat: audioFormat,
      sampleRateHertz: sampleRateHertz,
      languageCode: languageCode,
    );
  }

  // NEW: Triển khai phương thức generatePrescription
  @override
  Future<PrescriptionResponseModel> generatePrescription(Map<String, dynamic> prescriptionData) async {
    return await remoteDataSource.generatePrescription(prescriptionData);
  }
}