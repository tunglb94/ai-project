// clone/frontend/lib/core/services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../data/models/chat_response_model.dart';
import '../../data/models/lab_result_response_model.dart';
import '../../data/models/symptom_response_model.dart';
import '../../data/models/prescription_response_model.dart'; // NEW: Import PrescriptionResponseModel

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, required this.client});

  Future<ChatResponseModel> getChatResponse(String query) async {
    final response = await client.post(
      Uri.parse('$baseUrl/ai/chat'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return ChatResponseModel.fromJson(responseBody);
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Failed to get chat response. Status code: ${response.statusCode}. Detail: ${errorBody['detail']}');
    }
  }

  Future<SymptomResponseModel> analyzeSymptoms(Map<String, dynamic> symptomData) async {
    final response = await client.post(
      Uri.parse('$baseUrl/ai/analyze-symptoms'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(symptomData),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return SymptomResponseModel.fromJson(responseBody);
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Failed to analyze symptoms. Status code: ${response.statusCode}. Detail: ${errorBody['detail']}');
    }
  }

  Future<LabResultResponseModel> analyzeLabResultImage(File imageFile, String? testType) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await client.post(
      Uri.parse('$baseUrl/ai/analyze-lab-result'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'file': base64Image,
        'file_type': 'image/${imageFile.path.split('.').last}',
        'test_type': testType,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return LabResultResponseModel.fromJson(responseBody);
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Failed to analyze lab result image. Status code: ${response.statusCode}. Detail: ${errorBody['detail']}');
    }
  }

  Future<Map<String, dynamic>> sendVoiceChat({
    required String audioBase64,
    required String audioFormat,
    required int sampleRateHertz,
    required String languageCode,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/ai/voice-chat'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'audio_content': audioBase64,
        'audio_format': audioFormat,
        'sample_rate_hertz': sampleRateHertz,
        'language_code': languageCode,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Failed to send voice chat: ${errorBody['detail'] ?? response.statusCode}');
    }
  }

  // NEW: Phương thức để gửi yêu cầu kê đơn đến backend
  Future<PrescriptionResponseModel> generatePrescription(Map<String, dynamic> prescriptionData) async {
    final response = await client.post(
      Uri.parse('$baseUrl/ai/generate-prescription'), // Endpoint mới
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(prescriptionData),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes));
      return PrescriptionResponseModel.fromJson(responseBody);
    } else {
      final errorBody = json.decode(utf8.decode(response.bodyBytes));
      throw Exception('Failed to generate prescription. Status code: ${response.statusCode}. Detail: ${errorBody['detail']}');
    }
  }
}