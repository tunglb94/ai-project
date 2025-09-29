import 'package:equatable/equatable.dart';

abstract class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object> get props => [];
}

class GeneratePrescriptionRequested extends PrescriptionEvent {
  final String diagnosis;
  final String? symptoms;
  final int? patientAge;
  final double? patientWeight;
  final List<String>? allergies;
  final String? medicalHistory;
  final String? additionalNotes;

  const GeneratePrescriptionRequested({
    required this.diagnosis,
    this.symptoms,
    this.patientAge,
    this.patientWeight,
    this.allergies,
    this.medicalHistory,
    this.additionalNotes,
  });

  @override
  List<Object> get props => [
    diagnosis,
    symptoms ?? '',
    patientAge ?? 0,
    patientWeight ?? 0.0,
    allergies ?? [],
    medicalHistory ?? '',
    additionalNotes ?? '',
  ];
}