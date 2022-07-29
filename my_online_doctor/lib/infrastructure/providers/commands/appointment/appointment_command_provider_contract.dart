import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

import '../../../../domain/models/appointment/schedule_appointment_model.dart';

abstract class AppointmentCommandProviderContract {
  static AppointmentCommandProviderContract inject() =>
      _AppointmentCommandProvider();

  Future<void> cancelAppointment(CancelAppointmentModel appointment);

  Future<void> rejectAppointment(RejectAppointmentModel appointment);

  Future<void> scheduleAppointment(ScheduleAppointmentModel appointment);

  Future<void> callAppointment(AcceptAppointmentModel appointment);
}

enum AppointmentCommandProviderError {
  unauthorized,
  internalError,
}

class _AppointmentCommandProvider extends AppointmentCommandProviderContract {
  @override
  Future<dynamic> cancelAppointment(CancelAppointmentModel appointment) async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.cancelAppointment.path,
            body: appointment.toJson())
        .catchError((onError) {
      print(onError);
      return null;
    });
    return response;
  }

  @override
  Future<dynamic> rejectAppointment(RejectAppointmentModel appointment) async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.rejectAppointment.path,
            body: appointment.toJson())
        .catchError((onError) {
      return null;
    });

    return response;
  }

  @override
  Future<dynamic> scheduleAppointment(
      ScheduleAppointmentModel appointment) async {
    print(appointment.toJson());
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.scheduleAppointment.path,
            body: appointment.toJson())
        .catchError((onError) {
      return null;
    });
    print(response);
    return response;
  }

  @override
  Future<dynamic> callAppointment(AcceptAppointmentModel appointment) async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.callPatient.path,
            body: appointment.toJson())
        .catchError((onError) {
      return null;
    });

    return response;
  }
}
