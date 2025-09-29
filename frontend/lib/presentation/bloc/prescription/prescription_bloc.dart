import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/ai_repository.dart';
import 'prescription_event.dart';
import 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  final AiRepository aiRepository;

  PrescriptionBloc({required this.aiRepository}) : super(PrescriptionInitial()) {
    on<GeneratePrescriptionRequested>(_onGeneratePrescriptionRequested);
  }

  Future<void> _onGeneratePrescriptionRequested(
    GeneratePrescriptionRequested event,
    Emitter<PrescriptionState> emit,
  ) async {
    emit(PrescriptionLoading());
    try {
      final Map<String, dynamic> requestData = {
        'diagnosis': event.diagnosis,
        'symptoms': event.symptoms,
        'patient_age': event.patientAge,
        'patient_weight': event.patientWeight,
        'allergies': event.allergies,
        'medical_history': event.medicalHistory,
        'additional_notes': event.additionalNotes,
      };
      requestData.removeWhere((key, value) => value == null || (value is List && value.isEmpty));

      final prescription = await aiRepository.generatePrescription(requestData);
      emit(PrescriptionSuccess(prescription));
    } catch (e) {
      emit(PrescriptionFailure(e.toString()));
    }
  }
}