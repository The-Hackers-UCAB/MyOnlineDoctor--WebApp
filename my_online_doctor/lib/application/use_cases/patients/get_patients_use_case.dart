import 'package:my_online_doctor/application/use_cases/doctors/get_doctors_use_case.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/patient/patient_query_provider_contract.dart';

enum PatientUseCaseError { noPatientFound }

abstract class GetPatientsUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetPatientsUseCaseContract>(_GetPatientUseCase());

  static GetPatientsUseCaseContract get() =>
      getIt<GetPatientsUseCaseContract>();

  PatientQueryProviderContract provider = PatientQueryProviderContract.inject();

  Future<dynamic> run();
}

class _GetPatientUseCase extends GetPatientsUseCaseContract {
  @override
  Future<dynamic> run() async {
    return provider.getPatients();
  }
}

extension _ProviderMapper on PatientQueryProviderError {
  PatientUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return PatientUseCaseError.noPatientFound;
    }
  }
}
