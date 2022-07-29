//Project imports:
part of 'logout_bloc.dart';

///LoginEvent: Here we define the events of the LoginBloc.
abstract class LogoutEvent {}


class LogoutEventNavigateToWith extends LogoutEvent {
  final String routeName;
  LogoutEventNavigateToWith(this.routeName);
}

class LogoutEventLogoutPatient extends LogoutEvent {}


