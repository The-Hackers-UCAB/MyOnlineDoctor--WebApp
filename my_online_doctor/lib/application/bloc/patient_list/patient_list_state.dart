part of 'patient_list_bloc.dart';

@immutable
abstract class PatientListState {}

class PatientListInitial extends PatientListState {}

class PatientListLoading extends PatientListState {}

class PatientListHideLoading extends PatientListState {}

class PatientListDataFetched extends PatientListState {}
