import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class LabResultAnalyzerEvent extends Equatable {
  const LabResultAnalyzerEvent();
  @override
  List<Object> get props => [];
}

class AnalyzeLabResultImageSubmitted extends LabResultAnalyzerEvent {
  final File imageFile;
  final String? testType;

  const AnalyzeLabResultImageSubmitted({required this.imageFile, this.testType});

  @override
  List<Object> get props => [imageFile, testType ?? ''];
}