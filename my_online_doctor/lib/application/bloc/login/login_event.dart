//Project imports:
part of 'login_bloc.dart';

///LoginEvent: Here we define the events of the LoginBloc.
abstract class LoginEvent {}


class LoginEventFetchBasicData extends LoginEvent {}

class LoginEventNavigateTo extends LoginEvent {
  final String routeName;
  LoginEventNavigateTo(this.routeName);
}


class LoginEventLoginPatient extends LoginEvent {
  final SignInPatientDomainModel signInPatientDomainModel;
  final bool isFormValidated;

  LoginEventLoginPatient(this.signInPatientDomainModel, this.isFormValidated);
}
