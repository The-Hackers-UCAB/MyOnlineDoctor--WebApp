import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class AppointmentQueryProviderContract {
  static AppointmentQueryProviderContract inject() => _AppointmentQueryProvider();

  Future<void> getAppointments();

}

enum AppointmentQueryProviderError {
  unauthorized,
  internalError,
  AppointmentAlreadyRegistered,
}


class _AppointmentQueryProvider extends AppointmentQueryProviderContract {

  @override
  Future<dynamic> getAppointments() async {

    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationGet.key, endpoint: RepositoryPathConstant.getAppointmentsDoctor.path, )
    .catchError((onError) {

      return null;

    });

    return response;
  }
}