//Project import:
import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/schedule_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class AcceptAppointmentsUseCaseContract {
  static inject() => getIt.registerSingleton<AcceptAppointmentsUseCaseContract>(
      _AcceptAppointmentsUseCase());

  static AcceptAppointmentsUseCaseContract get() => getIt<AcceptAppointmentsUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider = AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(ScheduleAppointmentModel appointment);
}




class _AcceptAppointmentsUseCase extends AcceptAppointmentsUseCaseContract {

  @override
  Future<dynamic> run(ScheduleAppointmentModel appointment) async {

    return provider.scheduleAppointment(appointment);
  }
}


extension _ProviderMapper on AppointmentCommandProviderError {
  AppointmentUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return AppointmentUseCaseError.noAppointmentsFound;
    }
  }
}