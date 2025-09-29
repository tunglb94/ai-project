import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/ai_repository.dart';
import 'symptom_analyzer_event.dart';
import 'symptom_analyzer_state.dart';

class SymptomAnalyzerBloc extends Bloc<SymptomAnalyzerEvent, SymptomAnalyzerState> {
  final AiRepository aiRepository;

  SymptomAnalyzerBloc({required this.aiRepository}) : super(SymptomAnalyzerInitial()) {
    on<AnalyzeSymptomsSubmitted>((event, emit) async {
      emit(SymptomAnalyzerLoading());
      try {
        // Tạo một map từ các thuộc tính của sự kiện
        final Map<String, dynamic> requestData = {
          'symptoms_description': event.symptomsDescription, // Đảm bảo khớp với backend
          'department': event.department,
          'medical_history': event.medicalHistory,
          'family_history': event.familyHistory,
          'current_medications': event.currentMedications,
        };
        // Lọc bỏ các giá trị null nếu backend không xử lý tốt null
        requestData.removeWhere((key, value) => value == null);

        final result = await aiRepository.analyzeSymptoms(requestData);
        emit(SymptomAnalyzerSuccess(result));
      } catch (e) {
        emit(SymptomAnalyzerFailure(e.toString()));
      }
    });
  }
}