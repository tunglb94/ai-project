// clone/frontend/lib/data/models/prescription_response_model.dart

import 'package:equatable/equatable.dart';

class PrescriptionDrugModel extends Equatable {
  final String drugName;
  final String dosage;
  final String frequency;
  final String duration;
  final String? notes;
  final String? estimatedPrice; // NEW: Thêm trường estimatedPrice

  const PrescriptionDrugModel({
    required this.drugName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.notes,
    this.estimatedPrice, // NEW: Thêm estimatedPrice vào constructor
  });

  factory PrescriptionDrugModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionDrugModel(
      drugName: json['drug_name'] as String,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      duration: json['duration'] as String,
      notes: json['notes'] as String?,
      estimatedPrice: json['estimated_price'] as String?, // NEW: Đọc estimated_price
    );
  }

  @override
  List<Object?> get props => [drugName, dosage, frequency, duration, notes, estimatedPrice]; // NEW: Thêm estimatedPrice vào props
}

class PrescriptionResponseModel extends Equatable {
  final String prescriptionSummary;
  final List<PrescriptionDrugModel> drugs;
  final String? generalAdvice;
  final String disclaimer;
  final String? priceDisclaimer; // NEW: Thêm priceDisclaimer

  const PrescriptionResponseModel({
    required this.prescriptionSummary,
    required this.drugs,
    this.generalAdvice,
    required this.disclaimer,
    this.priceDisclaimer, // NEW: Thêm priceDisclaimer vào constructor
  });

  factory PrescriptionResponseModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionResponseModel(
      prescriptionSummary: json['prescription_summary'] as String,
      drugs: (json['drugs'] as List)
          .map((e) => PrescriptionDrugModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      generalAdvice: json['general_advice'] as String?,
      disclaimer: json['disclaimer'] as String,
      priceDisclaimer: json['price_disclaimer'] as String?, // NEW: Đọc price_disclaimer
    );
  }

  @override
  List<Object?> get props => [prescriptionSummary, drugs, generalAdvice, disclaimer, priceDisclaimer]; // NEW: Thêm priceDisclaimer vào props
}