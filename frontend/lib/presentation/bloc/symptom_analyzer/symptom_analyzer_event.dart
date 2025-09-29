import 'package:equatable/equatable.dart';

abstract class SymptomAnalyzerEvent extends Equatable {
  const SymptomAnalyzerEvent();
  @override
  List<Object> get props => [];
}

class AnalyzeSymptomsSubmitted extends SymptomAnalyzerEvent {
  final String symptomsDescription;
  final String? department;
  final String? medicalHistory;
  final String? familyHistory;
  final String? currentMedications;

  const AnalyzeSymptomsSubmitted({
    required this.symptomsDescription,
    this.department,
    this.medicalHistory,
    this.familyHistory,
    this.currentMedications,
  });

  @override
  List<Object> get props => [
    symptomsDescription,
    department ?? '',
    medicalHistory ?? '',
    familyHistory ?? '',
    currentMedications ?? '',
  ];
}