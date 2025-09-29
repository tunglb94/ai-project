import 'package:equatable/equatable.dart';
import '../../../data/models/lab_result_response_model.dart';

abstract class LabResultAnalyzerState extends Equatable {
  const LabResultAnalyzerState();
  @override
  List<Object> get props => [];
}

class LabResultAnalyzerInitial extends LabResultAnalyzerState {}

class LabResultAnalyzerLoading extends LabResultAnalyzerState {}

class LabResultAnalyzerSuccess extends LabResultAnalyzerState {
  final LabResultResponseModel result;

  const LabResultAnalyzerSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class LabResultAnalyzerFailure extends LabResultAnalyzerState {
  final String error;

  const LabResultAnalyzerFailure(this.error);

  @override
  List<Object> get props => [error];
}