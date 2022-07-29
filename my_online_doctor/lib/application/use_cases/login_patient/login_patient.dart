//Project import:
import 'package:my_online_doctor/domain/models/patient/sign_in_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/patient/patient_query_provider_contract.dart';

enum LoginPatientUseCaseError {patientNotRegistered }


abstract class LoginPatientUseCaseContract {
  static inject() => getIt.registerSingleton<LoginPatientUseCaseContract>(
      _LoginPatientUseCase());

  static LoginPatientUseCaseContract get() => getIt<LoginPatientUseCaseContract>();

  /// Providers
  PatientQueryProviderContract provider = PatientQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(SignInPatientDomainModel patient);
}




class _LoginPatientUseCase extends LoginPatientUseCaseContract {

  @override
  Future<dynamic> run(SignInPatientDomainModel patient) async {

    // try {
    //   await provider.LoginPatient(patient);
    // } on PatientQueryProviderError catch (error) {
    //   throw error.toUseCaseError();
    // }


    return provider.loginPatient(patient);
  }
}


extension _ProviderMapper on PatientQueryProviderError {
  LoginPatientUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return LoginPatientUseCaseError.patientNotRegistered;
    }
  }
}