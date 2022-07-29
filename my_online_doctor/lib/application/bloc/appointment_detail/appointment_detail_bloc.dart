import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/appointments/accept_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/call_patient_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/cancel_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/reject_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/schedule_appointment_use_case.dart';
import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/appointment_detail_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';

import '../../../domain/models/appointment/schedule_appointment_model.dart';
import '../../../infrastructure/ui/video_call/call.dart';
part 'appointment_detail_event.dart';
part 'appointment_detail_state.dart';

///AppointmentDetailBloc: Here we would have the AppointmentDetailDetail domain logic.
class AppointmentDetailBloc
    extends Bloc<AppointmentDetailEvent, AppointmentDetailState> {
  //Here the StreamController can be a state or a DomainModel
  final _appointmentDetailStreamController =
      StreamController<AppointmentDetailModel>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager =
      NavigatorServiceContract.get();
  final CancelAppointmentsUseCaseContract _cancelAppointmentUseCase =
      CancelAppointmentsUseCaseContract.get();
  final RejectAppointmentsUseCaseContract _rejectAppointmentUseCase =
      RejectAppointmentsUseCaseContract.get();
  final AcceptAppointmentsUseCaseContract _acceptAppointmentUseCase =
      AcceptAppointmentsUseCaseContract.get();
  final CallPatientUseCaseContract _callPatientUseCase =
      CallPatientUseCaseContract.get();
  final ScheduleAppointmentsUseCaseContract _scheduleAppointmentUseCase =
      ScheduleAppointmentsUseCaseContract.get();
  

  //Constructor
  //You have to declare the StateInitial as the first state
  AppointmentDetailBloc() : super(AppointmentDetailStateInitial()) {
    on<AppointmentDetailEventFetchBasicData>(
        _fetchBasicAppointmentDataEventToState);
    on<AppointmentDetailEventCancelled>(_cancelledAppointmentEventToState);
    on<AppointmentDetailEventRejected>(_rejectedAppointmentEventToState);
    on<ScheduleAppointmentDetailEventAccepted>(_scheduleAppointmentEventToState);
    on<AppointmentDetailEventNavigateToWith>(_navigateToWithEventToState);
    on<AppointmentDetailEventCalled>(_callPatientEventToState);
  }

  //Variables
  late AppointmentDetailModel _appointmentDetailModel;

  //Getters
  Stream<AppointmentDetailModel> get streamAppointmentDetail =>
      _appointmentDetailStreamController.stream;

  //Setters

  //Methods

  void _callPatientEventToState(AppointmentDetailEventCalled event,
      Emitter<AppointmentDetailState> emit) async {
    emit(AppointmentDetailStateLoading());

    final response = await _callPatientUseCase.run(event.appointment);

    print(response);
    _dispose();
    await Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (BuildContext rootContext) => CallPage(
          channelName: response['channelName'],
          role: ClientRole.Broadcaster,
        ),
      ),
    );

    emit(AppointmentDetailStateHideLoading());

    // _appointmentDetailStreamController.add(_appointmentDetailModel);
  }

  ///This method is called when the event is [AppointmentDetailEventFetchBasicData]
  ///It will fetch the basic data of the appointment and then it will dispatch the [AppointmentDetailEventFetchBasicData] event
  ///to the state.
  void _fetchBasicAppointmentDataEventToState(
      AppointmentDetailEventFetchBasicData event,
      Emitter<AppointmentDetailState> emit) {
    emit(AppointmentDetailStateLoading());

    _appointmentDetailModel = event.appointment;

    _appointmentDetailStreamController.add(event.appointment);

    emit(AppointmentDetailStateHideLoading());
  }

  ///This method is called when the event is [AppointmentEventDetailNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(AppointmentDetailEventNavigateToWith event,
      Emitter<AppointmentDetailState> emit) {
    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName,
        arguments: event.arguments);
  }

  ///This method is called when the event is [AppointmentDetailEventCancelled]
  ///It cancels the appointment.
  void _cancelledAppointmentEventToState(AppointmentDetailEventCancelled event,
      Emitter<AppointmentDetailState> emit) async {
    emit(AppointmentDetailStateLoading());

    final response = await _cancelAppointmentUseCase.run(event.appointment);

    if (response != null) {
      await showDialog(
          context: event.context,
          builder: (BuildContext superContext) => DialogComponent(
                textTitle: TextConstant.successTitle.text,
                textQuestion: TextConstant.successCancelAppointment.text,
              ));
    }

    _dispose();
    _navigatorManager.navigateToWithReplacement(
        "/bottom_menu"
        );

    emit(AppointmentDetailStateHideLoading());

    _appointmentDetailStreamController.add(_appointmentDetailModel);
  }

  ///This method is called when the event is [AppointmentDetailEventRejected]
  ///It rejects the appointment.
  ///It shows a dialog to the user to confirm the rejection.
  ///If the user confirms, it calls the use case to reject the appointment.
  ///If the user cancels, it does nothing.
  ///It also shows a dialog to the user if the appointment is rejected.
  void _rejectedAppointmentEventToState(AppointmentDetailEventRejected event,
      Emitter<AppointmentDetailState> emit) async {
    emit(AppointmentDetailStateLoading());

    final response = await _rejectAppointmentUseCase.run(event.appointment);

    if (response != null) {
      await showDialog(
          context: event.context,
          builder: (BuildContext superContext) => DialogComponent(
                textTitle: TextConstant.successTitle.text,
                textQuestion: TextConstant.successRejectAppointment.text,
              ));
    }
    _dispose();
    _navigatorManager.navigateToWithReplacement(
        "/bottom_menu"
        );

    emit(AppointmentDetailStateHideLoading());
  }

  ///This method is called when the event is [AppointmentDetailEventAccepted]
  ///It accepts the appointment.
  ///It shows a dialog to the user to confirm the acceptance.
  ///If the user confirms, it calls the use case to accept the appointment.
  ///If the user cancels, it does nothing.
  ///It also shows a dialog to the user if the appointment is accepted.
  void _scheduleAppointmentEventToState(ScheduleAppointmentDetailEventAccepted event,
      Emitter<AppointmentDetailState> emit) async {
    emit(AppointmentDetailStateLoading());

    final response = await _scheduleAppointmentUseCase.run(event.appointment);

    print(response);

    if (response != null) {
      await showDialog(
          context: event.context,
          builder: (BuildContext superContext) => DialogComponent(
                textTitle: TextConstant.successTitle.text,
                textQuestion: TextConstant.successAcceptAppointment.text,
              ));
    }
        _dispose();
    _navigatorManager.navigateToWithReplacement(
        "/bottom_menu"
        );

    emit(AppointmentDetailStateHideLoading());
  }

  //Private methods

  void _dispose() {
    _appointmentDetailStreamController.close();
  }
}
