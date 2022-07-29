//Project imports:
part of 'appointment_detail_bloc.dart';

//AppointmentDetailState: Here we define the states of the AppointmentDetailBloc.
abstract class AppointmentDetailState {}

class AppointmentDetailStateInitial extends AppointmentDetailState {}

class AppointmentDetailStateLoading extends AppointmentDetailState {}

class AppointmentDetailStateHideLoading extends AppointmentDetailState {}


