//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/doctors/get_doctors_use_case.dart';
import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';

//Project imports:
part 'doctor_event.dart';
part 'doctor_state.dart';

///DoctorBloc: Here we would have the Doctor domain logic.
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  //Here the StreamController can be a state or a DomainModel
  final _doctorStreamController = StreamController<List<DoctorRequestModel>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();
  final GetDoctorsUseCaseContract _getDoctorsUseCase =
      GetDoctorsUseCaseContract.get();

  DoctorBloc() : super(DoctorStateInitial()) {
    on<DoctorEventFetchBasicData>(_fetchBasicDataEventToState);
    on<DoctorEventNavigateTo>(_navigateToEventToState);
    on<DoctorEventSearchDoctor>(_searchEventToState);
    on<DoctorEventChangedSearchFilter>(_changedSearchFilterEventToState);
  }

  //Getters
  Stream<List<DoctorRequestModel>> get streamDoctor =>
      _doctorStreamController.stream;
  String get searchFilter => _searchFilter;

  //Setters
  set searchFilter(String value) => _searchFilter = value;

  //Variables
  String _searchFilter = 'Buscar por especialidad';

  //Methods:

  ///This method is called when the event is [DoctorEventFetchBasicData]
  ///It fetches the basic data of the doctor.
  void _fetchBasicDataEventToState(
      DoctorEventFetchBasicData event, Emitter<DoctorState> emit) async {
    emit(DoctorStateLoading());

    var response = await _getDoctorsUseCase.run(null);

    if (response != null) {
      var doctorsList =
          response.map((e) => doctorRequestModelFromJson(e)).toList();

      List<DoctorRequestModel> doctors = doctorsList.cast<DoctorRequestModel>();

      _doctorStreamController.sink.add(doctors);
    } else {
      _doctorStreamController.sink.add([]);
    }

    emit(DoctorStateHideLoading());
  }

  ///This method is called when the event is [DoctorEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToEventToState(
      DoctorEventNavigateTo event, Emitter<DoctorState> emit) {
    emit(DoctorStateLoading());
    // _dispose();
    _navigatorManager.navigateTo(event.routeName, arguments: event.arguments);

    emit(DoctorStateHideLoading());
  }

  ///This method is called when the event is [DoctorEventSearchDoctor]
  ///It searches for the doctor.
  ///It fetches the basic data of the doctor.
  void _searchEventToState(
      DoctorEventSearchDoctor event, Emitter<DoctorState> emit) async {
    emit(DoctorStateLoading());

    var filter = _filterMapper(event.search);

    var response = await _getDoctorsUseCase.run(filter);

    if (response != null) {
      var doctorsList =
          response.map((e) => doctorRequestModelFromJson(e)).toList();

      List<DoctorRequestModel> doctors = doctorsList.cast<DoctorRequestModel>();

      _doctorStreamController.sink.add(doctors);
    } else {
      _doctorStreamController.sink.add([]);
    }

    emit(DoctorStateHideLoading());
  }

  ///This method is called when the event is [DoctorEventChangedSearchFilter]
  ///It changes the search filter.
  void _changedSearchFilterEventToState(
      DoctorEventChangedSearchFilter event, Emitter<DoctorState> emit) {
    emit(DoctorStateLoading());

    searchFilter = event.searchFilter;

    emit(DoctorStateHideLoading());
  }

  //Private methods:

  void _dispose() {
    _doctorStreamController.close();
  }

  Map<String, dynamic>? _filterMapper(String search) {
    switch (searchFilter) {
      case 'Buscar por especialidad':
        return {'specialty': search};

      case 'Buscar por nombre':
        return {'firstName': search};

      case 'Buscar por apellido':
        return {'firstSurname': search};

      default:
        return null;
    }
  }
}
