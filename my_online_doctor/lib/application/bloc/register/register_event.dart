//Project imports:
part of 'register_bloc.dart';

///RegisterEvent: Here we define the events of the RegisterBloc.
abstract class RegisterEvent {}


class RegisterEventFetchBasicData extends RegisterEvent {}

class RegisterEventNavigateTo extends RegisterEvent {
  final String routeName;
  RegisterEventNavigateTo(this.routeName);
}

class RegisterEventRegisterPatient extends RegisterEvent {
  final SignUpPatientDomainModel signUpPatientDomainModel;
  final String confirmPassword;
  final bool isFormValidated;

  RegisterEventRegisterPatient(
    this.signUpPatientDomainModel,
    this.confirmPassword, 
    this.isFormValidated,
  );
}
