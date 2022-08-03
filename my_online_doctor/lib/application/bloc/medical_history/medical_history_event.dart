//Project imports:
part of 'medical_history_bloc.dart';

///MedicalHistoryEvent: Here we define the events of the MedicalHistoryBloc.
abstract class MedicalHistoryEvent {}

class MedicalHistoryEventFetchBasicData extends MedicalHistoryEvent {}

class MedicalHistoryEventNavigateToWith extends MedicalHistoryEvent {
  final String routeName;
  final Object? arguments;
  MedicalHistoryEventNavigateToWith(this.routeName, this.arguments);
}
