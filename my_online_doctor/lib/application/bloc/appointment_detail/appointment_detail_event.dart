//Project imports:
part of 'appointment_detail_bloc.dart';

///AppointmentDetailEvent: Here we define the events of the AppointmentDetailBloc.
abstract class AppointmentDetailEvent {}


class AppointmentDetailEventFetchBasicData extends AppointmentDetailEvent {
  final AppointmentDetailModel appointment;
  AppointmentDetailEventFetchBasicData(this.appointment);
}


class AppointmentDetailEventNavigateToWith extends AppointmentDetailEvent {
  final String routeName;
  final Object? arguments;
  AppointmentDetailEventNavigateToWith(this.routeName, {this.arguments});

}

class AppointmentDetailEventCancelled extends AppointmentDetailEvent {
  final CancelAppointmentModel appointment;
  final BuildContext context;

  AppointmentDetailEventCancelled(this.appointment, this.context);
}
class AppointmentDetailEventCalled extends AppointmentDetailEvent {
  final AcceptAppointmentModel appointment;
  final BuildContext context;

  AppointmentDetailEventCalled(this.appointment, this.context);
}

class AppointmentDetailEventAccepted extends AppointmentDetailEvent {
  final AcceptAppointmentModel appointment;
  final BuildContext context;

  AppointmentDetailEventAccepted(this.appointment, this.context);
}

class ScheduleAppointmentDetailEventAccepted extends AppointmentDetailEvent {
  final ScheduleAppointmentModel appointment;
  final BuildContext context;

  ScheduleAppointmentDetailEventAccepted(this.appointment, this.context);
}



class AppointmentDetailEventRejected extends AppointmentDetailEvent {
  final RejectAppointmentModel appointment;
  final BuildContext context;

  AppointmentDetailEventRejected(this.appointment, this.context);
}

