//Project import:
import 'package:my_online_doctor/domain/models/patient/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/patient/patient_command_provider_contract.dart';

enum RegisterPatientUseCaseError {patientAlreadyRegistered }


abstract class RegisterPatientUseCaseContract {
  static inject() => getIt.registerSingleton<RegisterPatientUseCaseContract>(
      _RegisterPatientUseCase());

  static RegisterPatientUseCaseContract get() => getIt<RegisterPatientUseCaseContract>();

  /// Providers
  PatientCommandProviderContract provider = PatientCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(SignUpPatientDomainModel patient);
}




class _RegisterPatientUseCase extends RegisterPatientUseCaseContract {

  @override
  Future<dynamic> run(SignUpPatientDomainModel patient) async {
    
    // try {
    //   await provider.registerPatient(patient);
    // } on PatientCommandProviderError catch (error) {
    //   throw error.toUseCaseError();
    // }


    return provider.registerPatient(patient);
  }
}


extension _ProviderMapper on PatientCommandProviderError {
  RegisterPatientUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return RegisterPatientUseCaseError.patientAlreadyRegistered;
    }
  }
}