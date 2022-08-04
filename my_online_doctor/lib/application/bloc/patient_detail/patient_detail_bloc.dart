import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';

part 'patient_detail_event.dart';

part 'patient_detail_state.dart';

class PatientDetailBloc extends Bloc<PatientDetailEvent, PatientDetailState> {
  //Here the StreamController can be a state or a DomainModel
  final _patientDetailStreamController =
      StreamController<PatientRequestModel>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();

  //Constructor
  //You have to declare the StateInitial as the first state
  PatientDetailBloc() : super(PatientDetailStateInitial()) {
    on<PatientDetailEventFetchBasicData>(_fetchBasicPatientDataEventToState);
  }

  //Variables
  late PatientRequestModel _patientDetailModel;

  //Getters
  Stream<PatientRequestModel> get streamPatientDetail =>
      _patientDetailStreamController.stream;

  //Setters

  //Methods

  ///This method is called when the event is [PatientDetailEventFetchBasicData]
  ///It will fetch the basic data of the Patient and then it will dispatch the [PatientDetailEventFetchBasicData] event
  ///to the state.
  void _fetchBasicPatientDataEventToState(
      PatientDetailEventFetchBasicData event,
      Emitter<PatientDetailState> emit) {
    emit(PatientDetailStateLoading());

    _patientDetailModel = event.Patient;

    _patientDetailStreamController.add(event.Patient);

    emit(PatientDetailStateHideLoading());
  }

  ///This method is called when the event is [PatientEventDetailNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(PatientDetailEventNavigateToWith event,
      Emitter<PatientDetailState> emit) {
    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName,
        arguments: event.arguments);
  }

  //Private methods

  void _dispose() {
    _patientDetailStreamController.close();
  }
}
