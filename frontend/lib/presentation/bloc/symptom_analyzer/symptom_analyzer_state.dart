import 'package:equatable/equatable.dart';
import '../../../data/models/symptom_response_model.dart';

abstract class SymptomAnalyzerState extends Equatable {
  const SymptomAnalyzerState();
  @override
  List<Object> get props => [];
}

class SymptomAnalyzerInitial extends SymptomAnalyzerState {}

class SymptomAnalyzerLoading extends SymptomAnalyzerState {}

class SymptomAnalyzerSuccess extends SymptomAnalyzerState {
  final SymptomResponseModel result;
  const SymptomAnalyzerSuccess(this.result);
  @override
  List<Object> get props => [result];
}

class SymptomAnalyzerFailure extends SymptomAnalyzerState {
  final String error;
  const SymptomAnalyzerFailure(this.error);
  @override
  List<Object> get props => [error];
}