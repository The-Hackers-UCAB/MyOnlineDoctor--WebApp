//Project import:
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class CancelAppointmentsUseCaseContract {
  static inject() => getIt.registerSingleton<CancelAppointmentsUseCaseContract>(
      _CancelAppointmentsUseCase());

  static CancelAppointmentsUseCaseContract get() => getIt<CancelAppointmentsUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider = AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(CancelAppointmentModel appointment);
}




class _CancelAppointmentsUseCase extends CancelAppointmentsUseCaseContract {

  @override
  Future<dynamic> run(CancelAppointmentModel appointment) async {

    return provider.cancelAppointment(appointment);
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