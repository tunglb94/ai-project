import 'package:equatable/equatable.dart';
import '../../../data/models/prescription_response_model.dart';

abstract class PrescriptionState extends Equatable {
  const PrescriptionState();

  @override
  List<Object> get props => [];
}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionSuccess extends PrescriptionState {
  final PrescriptionResponseModel prescription;

  const PrescriptionSuccess(this.prescription);

  @override
  List<Object> get props => [prescription];
}

class PrescriptionFailure extends PrescriptionState {
  final String error;

  const PrescriptionFailure(this.error);

  @override
  List<Object> get props => [error];
}