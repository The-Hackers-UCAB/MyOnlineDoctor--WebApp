//Project imports:
part of 'patient_detail_bloc.dart';

//PatientDetailState: Here we define the states of the PatientDetailBloc.
abstract class PatientDetailState {}

class PatientDetailStateInitial extends PatientDetailState {}

class PatientDetailStateLoading extends PatientDetailState {}

class PatientDetailStateHideLoading extends PatientDetailState {}
