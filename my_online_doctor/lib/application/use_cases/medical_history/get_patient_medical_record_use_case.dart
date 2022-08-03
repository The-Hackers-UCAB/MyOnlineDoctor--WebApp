//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/medicalrecord/patient_medical_record_query_provider_contract.dart';

enum GetPatientMedicalRecordUseCaseError { noPatientFound }

abstract class GetPatientMedicalRecordUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetPatientMedicalRecordUseCaseContract>(
          _GetPatientMedicalRecordUseCase());

  static GetPatientMedicalRecordUseCaseContract get() =>
      getIt<GetPatientMedicalRecordUseCaseContract>();

  /// Providers
  PatientMedicalRecordQueryProviderContract provider =
      PatientMedicalRecordQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(); //TDOO: add model
}

class _GetPatientMedicalRecordUseCase
    extends GetPatientMedicalRecordUseCaseContract {
  @override
  Future<dynamic> run() async {
    return provider.getPatientMedicalRecord();
  }
}

extension _ProviderMapper on PatientMedicalRecordQueryProviderError {
  GetPatientMedicalRecordUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return GetPatientMedicalRecordUseCaseError.noPatientFound;
    }
  }
}
