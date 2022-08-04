import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class PatientMedicalHistoryQueryProviderContract {
  static PatientMedicalHistoryQueryProviderContract inject() =>
      _PatientMedicalHistoryQueryProvider();

  Future<void> getPatientMedicalRecord(String patientId); //TDOO: add model
}

enum PatientMedicalHistoryQueryProviderError {
  unauthorized,
  internalError,
}

class _PatientMedicalHistoryQueryProvider
    extends PatientMedicalHistoryQueryProviderContract {
  @override
  Future<dynamic> getPatientMedicalRecord(String patientId) async {
    final response = await getIt<RepositoryManager>().request(
      operation: RepositoryConstant.operationPost.key,
      endpoint: RepositoryPathConstant.getMedicalHistory.path,
      body: {'patientId': patientId},
    ).catchError((onError) {
      return null;
    });

    return response;
  }
}
