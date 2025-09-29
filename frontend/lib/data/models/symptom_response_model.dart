// lib/data/models/symptom_response_model.dart

class SymptomResponseModel {
  final List<String> recommendedSpecialties;
  final String potentialInfo;
  final String disclaimer;

  SymptomResponseModel({
    required this.recommendedSpecialties,
    required this.potentialInfo,
    required this.disclaimer,
  });

  factory SymptomResponseModel.fromJson(Map<String, dynamic> json) {
    return SymptomResponseModel(
      recommendedSpecialties: List<String>.from(json['recommended_specialties']),
      potentialInfo: json['potential_info'],
      disclaimer: json['disclaimer'],
    );
  }
}