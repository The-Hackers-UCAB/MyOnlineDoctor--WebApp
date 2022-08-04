//Project imports:
part of 'doctor_bloc.dart';

///DoctorEvent: Here we define the events of the DoctorBloc.
abstract class DoctorEvent {}

class DoctorEventFetchBasicData extends DoctorEvent {}

class DoctorEventNavigateTo extends DoctorEvent {
  final String routeName;
  final Object? arguments;
  DoctorEventNavigateTo(this.routeName, this.arguments);
}

class DoctorEventSearchDoctor extends DoctorEvent {
  final String search;
  DoctorEventSearchDoctor(this.search);
}

class DoctorEventChangedSearchFilter extends DoctorEvent {
  final String searchFilter;
  DoctorEventChangedSearchFilter(this.searchFilter);
}
