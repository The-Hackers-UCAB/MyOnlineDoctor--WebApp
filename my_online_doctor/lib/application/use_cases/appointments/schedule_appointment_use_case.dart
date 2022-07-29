//Project import:
import 'package:my_online_doctor/domain/models/appointment/schedule_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class ScheduleAppointmentsUseCaseContract {
  static inject() => getIt.registerSingleton<ScheduleAppointmentsUseCaseContract>(
      _ScheduleAppointmentsUseCase());

  static ScheduleAppointmentsUseCaseContract get() => getIt<ScheduleAppointmentsUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider = AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(ScheduleAppointmentModel appointment);
}




class _ScheduleAppointmentsUseCase extends ScheduleAppointmentsUseCaseContract {

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