//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/medical_record/patient_medical_history_query_provider_contract.dart';

enum GetPatientMedicalRecordUseCaseError { noPatientFound }

abstract class GetPatientMedicalRecordUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetPatientMedicalRecordUseCaseContract>(
          _GetPatientMedicalRecordUseCase());

  static GetPatientMedicalRecordUseCaseContract get() =>
      getIt<GetPatientMedicalRecordUseCaseContract>();

  /// Providers
  PatientMedicalHistoryQueryProviderContract provider =
      PatientMedicalHistoryQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String patientId); //TDOO: add model
}

class _GetPatientMedicalRecordUseCase
    extends GetPatientMedicalRecordUseCaseContract {
  @override
  Future<dynamic> run(String patientId) async {
    print('From UseCase $patientId');
    return provider.getPatientMedicalRecord(patientId);
  }
}

// extension _ProviderMapper on PatientMedicalRecordQueryProviderError {
//   GetPatientMedicalRecordUseCaseError toUseCaseError() {
//     switch (this) {
//       default:
//         return GetPatientMedicalRecordUseCaseError.noPatientFound;
//     }
//   }
// }
