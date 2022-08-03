import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class MedicalRecordQueryProviderContract {
  static MedicalRecordQueryProviderContract inject() =>
      _MedicalRecordQueryProvider();

  Future<void> getMedicalRecords();
}

enum MedicalRecordQueryProviderError {
  unauthorized,
  internalError,
  MedicalRecordAlreadyExists,
}

class _MedicalRecordQueryProvider extends MedicalRecordQueryProviderContract {
  @override
  Future<dynamic> getMedicalRecords() async {
    final response = await getIt<RepositoryManager>()
        .request(
      operation: RepositoryConstant.operationPost.key,
      endpoint: RepositoryPathConstant.createMedicalRecord.path,
    )
        .catchError((onError) {
      return null;
    });

    return response;
  }
}
