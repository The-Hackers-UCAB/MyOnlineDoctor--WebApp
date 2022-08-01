part of 'medical_record_bloc.dart';

abstract class MedicalRecordState{}

class MedicalRecordStateInitial extends MedicalRecordState {}

class MedicalRecordStateLoading extends MedicalRecordState {}

class MedicalRecordStateHideLoading extends MedicalRecordState {}

class MedicalRecordStateDataFetched extends MedicalRecordState {}

class MedicalRecordStateSuccess extends MedicalRecordState {}