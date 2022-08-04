//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/medical_history/get_patient_medical_record_use_case.dart';
//import 'package:my_online_doctor/application/use_cases/medical_History/get_patient_medical_History_use_case.dart';
import 'package:my_online_doctor/domain/models/medical_history_record/view_medical_history_model.dart';
import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
part 'medical_history_event.dart';
part 'medical_history_state.dart';

///MedicalHistoryBloc: Here we would have the Login domain logic.
class MedicalHistoryBloc
    extends Bloc<MedicalHistoryEvent, MedicalHistoryState> {
  //Here the StreamController can be a state or a DomainModel
  final _medicalHistoryStreamController =
      StreamController<List<MedicalRecordModel>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();

  final GetPatientMedicalRecordUseCaseContract
      _getPatientMedicalHistoryUseCase =
      GetPatientMedicalRecordUseCaseContract.get();

  //Constructor
  //You have to declare the StateInitial as the first state
  MedicalHistoryBloc() : super(MedicalHistoryStateInitial()) {
    on<MedicalHistoryEventNavigateToWith>(_navigateToWithEventToState);
    on<MedicalHistoryEventFetchBasicData>(_fetchBasicDataEventToState);
  }

  //Getters
  Stream<List<MedicalRecordModel>> get streamMedicalHistory =>
      _medicalHistoryStreamController.stream;

  //Methods:

  ///This method is called when the event is [MedicalHistoryEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(
    MedicalHistoryEventNavigateToWith event,
    Emitter<MedicalHistoryState> emit,
  ) {
    _navigatorManager.pop();
    _dispose();
  }

  ///This method is called when the event is [MedicalHistoryEventFetchBasicData]
  ///It fetches the basic data.
  ///It is a use case that is called from the [MedicalHistoryBloc]
  void _fetchBasicDataEventToState(
    MedicalHistoryEventFetchBasicData event,
    Emitter<MedicalHistoryState> emit,
  ) async {
    emit(MedicalHistoryStateLoading());

    final response =
        await _getPatientMedicalHistoryUseCase.run(event.patient.id);

    if (response.isNotEmpty) {
      final medicalHistoryList =
          response.map((e) => getMedicalRecordModelFromJson(e)).toList();

      List<MedicalRecordModel> medicalHistory =
          medicalHistoryList.cast<MedicalRecordModel>();

      _medicalHistoryStreamController.sink.add(medicalHistory);
    } else {
      _medicalHistoryStreamController.sink.add([]);
    }

    emit(MedicalHistoryStateHideLoading());
  }

  //Private methods:

  void _dispose() {
    _medicalHistoryStreamController.close();
  }
}
