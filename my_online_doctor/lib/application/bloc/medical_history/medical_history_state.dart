//Project imports:
part of 'medical_history_bloc.dart';

//MedicalHistoryState: Here we define the states of the MedicalHistoryBloc.
abstract class MedicalHistoryState {}

class MedicalHistoryStateInitial extends MedicalHistoryState {}

class MedicalHistoryStateLoading extends MedicalHistoryState {}

class MedicalHistoryStateHideLoading extends MedicalHistoryState {}
