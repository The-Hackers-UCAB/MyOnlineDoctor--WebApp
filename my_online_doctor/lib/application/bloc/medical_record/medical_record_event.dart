part of 'medical_record_bloc.dart';

abstract class MedicalRecordEvent {}

class MedicalRecordEventFetchBasicData extends MedicalRecordEvent {}

class MedicalRecordEventNavigateTo extends MedicalRecordEvent {
  final String routeName;

  MedicalRecordEventNavigateTo(this.routeName);
}

class MedicalRecordEventRegister extends MedicalRecordEvent {
  final MedicalRecordDomainModel medicalRecordDomainModel;

  MedicalRecordEventRegister(
    this.medicalRecordDomainModel,
  );
}
