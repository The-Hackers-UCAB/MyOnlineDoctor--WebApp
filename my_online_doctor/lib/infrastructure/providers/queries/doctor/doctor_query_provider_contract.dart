import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class DoctorQueryProviderContract {
  static DoctorQueryProviderContract inject() => _DoctorQueryProvider();

  Future<void> getDoctors(Map<String, dynamic>? filter);
}

enum DoctorQueryProviderError {
  unauthorized,
  internalError,
}

class _DoctorQueryProvider extends DoctorQueryProviderContract {
  @override
  Future<dynamic> getDoctors(Map<String, dynamic>? filter) async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.getDoctors.path,
            body: filter ?? {})
        .catchError((onError) {
      return null;
    });

    return response;
  }
}
