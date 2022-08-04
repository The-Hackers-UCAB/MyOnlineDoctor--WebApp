//Project imports:
part of 'medical_record_bloc.dart';

///MedicalRecordEvent: Here we define the events of the MedicalRecordBloc.
abstract class MedicalRecordEvent {}

class MedicalRecordEventFetchBasicData extends MedicalRecordEvent {}

class MedicalRecordEventNavigateToWith extends MedicalRecordEvent {
  final String routeName;
  final Object? arguments;
  MedicalRecordEventNavigateToWith(this.routeName, this.arguments);
}
