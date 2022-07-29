//Project imports:
part of 'appointment_bloc.dart';

//AppointmentState: Here we define the states of the AppointmentBloc.
abstract class AppointmentState {}

class AppointmentStateInitial extends AppointmentState {}

class AppointmentStateLoading extends AppointmentState {}

class AppointmentStateHideLoading extends AppointmentState {}


