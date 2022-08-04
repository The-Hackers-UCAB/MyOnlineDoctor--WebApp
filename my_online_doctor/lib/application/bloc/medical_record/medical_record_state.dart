//Project imports:
part of 'medical_record_bloc.dart';

//MedicalRecordState: Here we define the states of the MedicalRecordBloc.
abstract class MedicalRecordState {}

class MedicalRecordStateInitial extends MedicalRecordState {}

class MedicalRecordStateLoading extends MedicalRecordState {}

class MedicalRecordStateHideLoading extends MedicalRecordState {}
