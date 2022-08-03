import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class PatientMedicalRecordQueryProviderContract {
  static PatientMedicalRecordQueryProviderContract inject() =>
      _PatientMedicalRecordQueryProvider();

  Future<void> getPatientMedicalRecord(); //TDOO: add model
}

enum PatientMedicalRecordQueryProviderError {
  unauthorized,
  internalError,
}

class _PatientMedicalRecordQueryProvider
    extends PatientMedicalRecordQueryProviderContract {
  @override
  Future<dynamic> getPatientMedicalRecord() async {
    final response = await getIt<RepositoryManager>()
        .request(
      operation: RepositoryConstant.operationGet.key,
      endpoint: RepositoryPathConstant.getPatientMedicalRecord.path,
    )
        .catchError((onError) {
      return null;
    });

    return response;
  }
}
