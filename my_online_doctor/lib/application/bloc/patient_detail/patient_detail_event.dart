//Project imports:
part of 'patient_detail_bloc.dart';

///PatientDetailEvent: Here we define the events of the PatientDetailBloc.
abstract class PatientDetailEvent {}

class PatientDetailEventFetchBasicData extends PatientDetailEvent {
  final PatientRequestModel Patient;
  PatientDetailEventFetchBasicData(this.Patient);
}

class PatientDetailEventNavigateToWith extends PatientDetailEvent {
  final String routeName;
  final Object? arguments;
  PatientDetailEventNavigateToWith(this.routeName, {this.arguments});
}
