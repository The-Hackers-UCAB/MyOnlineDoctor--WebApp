import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_online_doctor/application/use_cases/patients/get_patients_use_case.dart';
import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:string_similarity/string_similarity.dart';

part 'patient_list_event.dart';
part 'patient_list_state.dart';

class PatientListBloc extends Bloc<PatientListEvent, PatientListState> {
  final _patientStreamController =
      StreamController<List<PatientRequestModel>>();

  List<PatientRequestModel> _patients = [];

  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();

  final GetPatientsUseCaseContract _getPatientsUseCase =
      GetPatientsUseCaseContract.get();

  String _searchFilter = 'Buscar por nombre';

  PatientListBloc() : super(PatientListInitial()) {
    on<FetchBasicData>(_fetchBasicDataEventToState);
    on<NavigateTo>(_navigateToEventToState);
    on<ChangedSearchFilter>(_changedSearchFilterEventToState);
    on<SearchPatient>(_searchEventToState);
  }

  Stream<List<PatientRequestModel>> get streamPatient =>
      _patientStreamController.stream;

  set searchFilter(String value) => _searchFilter = value;

  String get searchFilter => _searchFilter;

  void _searchEventToState(
    SearchPatient event,
    Emitter<PatientListState> emit,
  ) {
    emit(PatientListLoading());

    showPatients(_patients);

    if (_patients.isNotEmpty) {
      List<PatientRequestModel> filteredPatients = [];

      switch (searchFilter) {
        case 'Buscar por nombre':
          filteredPatients = _filterPatiens(event.search, SearchFilter.byName);
          break;

        case 'Buscar por apellido':
          filteredPatients =
              _filterPatiens(event.search, SearchFilter.bySurname);
          break;
      }
      if (event.search == '') {
        filteredPatients = _patients;
        print("Esta vacio");
      }

      showPatients(filteredPatients);
      _patientStreamController.sink.add(filteredPatients);
    } else {
      _patientStreamController.sink.add([]);
    }
    emit(PatientListHideLoading());
  }

  List<PatientRequestModel> _filterPatiens(String search, SearchFilter filter) {
    return _patients.where((patient) {
      String fieldToCompare;

      switch (filter) {
        case SearchFilter.byName:
          fieldToCompare = patient.firstName;
          break;
        case SearchFilter.bySurname:
          fieldToCompare = patient.firstSurname;
          break;
      }
      double threshold = 0.6;

      double similarity =
          fieldToCompare.toLowerCase().similarityTo(search.toLowerCase());
      print("$search == $fieldToCompare");
      print("Similarity: $similarity");

      return similarity >= threshold;
    }).toList();
  }

  void _changedSearchFilterEventToState(
    ChangedSearchFilter event,
    Emitter<PatientListState> emit,
  ) {
    _searchFilter = event.searchFilter;
    print(_searchFilter);
  }

  void _fetchBasicDataEventToState(
    FetchBasicData event,
    Emitter<PatientListState> emit,
  ) async {
    emit(PatientListLoading());

    var response = await _getPatientsUseCase.run();

    if (response != null) {
      var patientsList =
          response.map((e) => patientRequestModelFromJson(e)).toList();

      List<PatientRequestModel> patients =
          patientsList.cast<PatientRequestModel>();

      _patients = patients;

      _patientStreamController.sink.add(patients);
    } else {
      _patientStreamController.sink.add([]);
    }

    emit(PatientListHideLoading());
  }

  void _navigateToEventToState(
    NavigateTo event,
    Emitter<PatientListState> emit,
  ) {
    emit(PatientListLoading());
    _navigatorManager.navigateTo(
      event.routeName,
      arguments: event.arguments,
    );

    emit(PatientListHideLoading());
  }
}

//TODO: Delete thus
void showPatients(List<PatientRequestModel> patients) {
  String strPatients = patients
      .map((patient) {
        return "${patient.firstName} ${patient.firstSurname}";
      })
      .toList()
      .join(", ");
  print("pacientes");
  print("[$strPatients]");
}

enum SearchFilter {
  byName,
  bySurname,
}
