import 'package:equatable/equatable.dart';

class LabIndicatorModel extends Equatable {
  final String indicatorName;
  final String value;
  final String unit;
  final String referenceRange;
  final String interpretation;
  final String explanation;
  final List<String> questionsForDoctor;

  const LabIndicatorModel({
    required this.indicatorName,
    required this.value,
    required this.unit,
    required this.referenceRange,
    required this.interpretation,
    required this.explanation,
    required this.questionsForDoctor,
  });

  factory LabIndicatorModel.fromJson(Map<String, dynamic> json) {
    return LabIndicatorModel(
      indicatorName: json['indicator_name'] as String,
      value: json['value'] as String,
      unit: json['unit'] as String,
      referenceRange: json['reference_range'] as String,
      interpretation: json['interpretation'] as String,
      explanation: json['explanation'] as String,
      questionsForDoctor: List<String>.from(json['questions_for_doctor'] as List),
    );
  }

  @override
  List<Object?> get props => [
        indicatorName,
        value,
        unit,
        referenceRange,
        interpretation,
        explanation,
        questionsForDoctor,
      ];
}

class LabResultResponseModel extends Equatable {
  final String summary;
  final String? overallInterpretation;
  final List<LabIndicatorModel> abnormalIndicators;
  final String? normalIndicators_summary;
  final String? health_insights;
  final List<String>? recommendations;

  const LabResultResponseModel({
    required this.summary,
    this.overallInterpretation,
    required this.abnormalIndicators,
    this.normalIndicators_summary,
    this.health_insights,
    this.recommendations,
  });

  factory LabResultResponseModel.fromJson(Map<String, dynamic> json) {
    return LabResultResponseModel(
      summary: json['summary'] as String,
      overallInterpretation: json['overall_interpretation'] as String?,
      abnormalIndicators: (json['abnormal_indicators'] as List)
          .map((e) => LabIndicatorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      normalIndicators_summary: json['normal_indicators_summary'] as String?,
      health_insights: json['health_insights'] as String?,
      recommendations: json['recommendations'] != null 
          ? List<String>.from(json['recommendations'] as List) 
          : null,
    );
  }

  @override
  List<Object?> get props => [
        summary,
        overallInterpretation,
        abnormalIndicators,
        normalIndicators_summary,
        health_insights,
        recommendations,
      ];
}