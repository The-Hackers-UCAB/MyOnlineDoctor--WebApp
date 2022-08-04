part of 'patient_list_bloc.dart';

@immutable
abstract class PatientListEvent {}

class FetchBasicData extends PatientListEvent {}

class NavigateTo extends PatientListEvent {
  final String routeName;
  final Object? arguments;
  NavigateTo(this.routeName, this.arguments);
}

class SearchPatient extends PatientListEvent {
  final String search;
  SearchPatient(this.search);
}

class ChangedSearchFilter extends PatientListEvent {
  final String searchFilter;
  ChangedSearchFilter(this.searchFilter);
}
