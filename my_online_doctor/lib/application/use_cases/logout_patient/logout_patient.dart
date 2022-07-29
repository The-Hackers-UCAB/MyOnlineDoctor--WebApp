//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/patient/patient_query_provider_contract.dart';

enum LogoutPatientUseCaseError {logoutPatientError}

abstract class LogoutPatientUseCaseContract {
  static inject() => getIt.registerSingleton<LogoutPatientUseCaseContract>(
      _LogoutPatientUseCase());

  static LogoutPatientUseCaseContract get() => getIt<LogoutPatientUseCaseContract>();

  /// Providers
  PatientQueryProviderContract provider = PatientQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run();
}

class _LogoutPatientUseCase extends LogoutPatientUseCaseContract {

  @override
  Future<dynamic> run() async {
    return provider.logoutPatient();
  }
}

extension _ProviderMapper on PatientQueryProviderError {
  LogoutPatientUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return LogoutPatientUseCaseError.logoutPatientError;
    }
  }
}