//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/medical_record/patient_medical_history_query_provider_contract.dart';

enum GetPatientMedicalHistoryUseCaseError { noPatientFound }

abstract class GetPatientMedicalHistoryUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetPatientMedicalHistoryUseCaseContract>(
          _GetPatientMedicalRecordUseCase());

  static GetPatientMedicalHistoryUseCaseContract get() =>
      getIt<GetPatientMedicalHistoryUseCaseContract>();

  /// Providers
  PatientMedicalHistoryQueryProviderContract provider =
      PatientMedicalHistoryQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(String patientId); //TDOO: add model
}

class _GetPatientMedicalRecordUseCase
    extends GetPatientMedicalHistoryUseCaseContract {
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
