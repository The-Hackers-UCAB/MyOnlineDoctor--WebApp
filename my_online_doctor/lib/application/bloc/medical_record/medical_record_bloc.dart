import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';

import '../../../domain/models/medicalRecord/medical_record_domain_model.dart';
import '../../../infrastructure/core/constants/text_constants.dart';
import '../../../infrastructure/core/context_manager.dart';
import '../../../infrastructure/core/injection_manager.dart';
import '../../../infrastructure/core/navigator_manager.dart';

part 'medical_record_state.dart';
part 'medical_record_event.dart';

class MedicalRecordBloc extends Bloc<MedicalRecordEvent, MedicalRecordState> {
  final _medicalRecordStreamController = StreamController<bool>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();
  final GetPhonesUseCaseContract _phonesUseCase =
      GetPhonesUseCaseContract.get();
  final GetGenreUseCaseContract _genreUseCase = GetGenreUseCaseContract.get();

  //Variables:
  DateTime _date = DateTime.now();
  List<String> _phonesList = [];
  String? _phoneSelected;
  List<String> _genresList = [];
  String? _genreSelected;
  DateTime _birthDate = DateTime.now();
  bool _termsAndConditionsSelected = false;

  //Constructor
  //You have to declare the StateInitial as the first state
  MedicalRecordBloc() : super(MedicalRecordStateInitial()) {
    on<MedicalRecordEventNavigateTo>(_navigateToEventToState);
    on<MedicalRecordEventRegister>(_registerMedicalRecordEventToState);
    on<MedicalRecordEventFetchBasicData>(_fetchBasicMedicalRecordEventToState);
  }

  //Getters
  Stream<bool> get streamMedicalRecord => _medicalRecordStreamController.stream;
  DateTime get date => _date;

  //Setters
  set date(DateTime value) {
    _date = value;
    _loadView();
  }

  //Methods:
  ///This method is called when the event is [MedicalRecordEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToEventToState(
      MedicalRecordEventNavigateTo event, Emitter<MedicalRecordState> emit) {
    _dispose();

    if (event.routeName == '/view_appointments') {
      _navigatorManager.pop(null);
    } else {
      _navigatorManager.navigateTo(event.routeName);
    }
  }

  void _setInitalMedicalRecordData() {
    _phoneSelected = _phonesList.first;
    _genreSelected = _genresList.first;
  }

  void _fetchBasicMedicalRecordEventToState(
      MedicalRecordEvent event, Emitter<MedicalRecordState> emit) async {
    emit(MedicalRecordStateLoading());

    _phonesList = await _phonesUseCase.run();
    _genresList = await _genreUseCase.run();

    _setInitalMedicalRecordData();

    _loadView();

    emit(MedicalRecordStateDataFetched());
  }

  void _navigateEventFetchMedicalData(
      MedicalRecordEventNavigateTo event, Emitter<MedicalRecordState> emit) {
    _dispose();

    if (event.routeName == '/view_appointments') {
      _navigatorManager.pop(null);
    } else {
      _navigatorManager.navigateTo(event.routeName);
    }
  }

  ///This method is called when the event is [MedicalRecordEventRegister]
  ///It registers the patient.
  bool _registerMedicalRecordEventToState(
      MedicalRecordEventRegister event, Emitter<MedicalRecordState> emit) {
    if (_date.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      _showDialog(
          TextConstant.errorTitle.text, TextConstant.medicalRecordDate.text);
      return false;
    }

    return true;
  }

  //To load the view:
  void _loadView() => _medicalRecordStreamController.sink.add(true);

  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    var newContext = getIt<ContextManager>().context;

    return await showDialog(
        context: newContext,
        builder: (BuildContext dialogContext) =>
            Builder(builder: (superContext) {
              return DialogComponent(
                textTitle: textTitle,
                textQuestion: textQuestion,
              );
            }));
  }

  void _dispose() {
    _medicalRecordStreamController.close();
  }
}
