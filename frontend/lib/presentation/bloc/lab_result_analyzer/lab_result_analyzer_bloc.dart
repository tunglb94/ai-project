// clone/frontend/lib/presentation/bloc/lab_result_analyzer/lab_result_analyzer_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/ai_repository.dart';
import 'lab_result_analyzer_event.dart';
import 'lab_result_analyzer_state.dart';

class LabResultAnalyzerBloc extends Bloc<LabResultAnalyzerEvent, LabResultAnalyzerState> {
  final AiRepository aiRepository;

  LabResultAnalyzerBloc({required this.aiRepository}) : super(LabResultAnalyzerInitial()) {
    on<AnalyzeLabResultImageSubmitted>((event, emit) async {
      emit(LabResultAnalyzerLoading());
      try {
        // Truyền testType vào repository
        final result = await aiRepository.analyzeLabResultImage(event.imageFile, event.testType);
        emit(LabResultAnalyzerSuccess(result));
      } catch (e) {
        emit(LabResultAnalyzerFailure(e.toString()));
      }
    });
  }
}