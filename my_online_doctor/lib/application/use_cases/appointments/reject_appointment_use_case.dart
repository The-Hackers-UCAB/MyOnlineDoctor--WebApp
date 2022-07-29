//Project import:
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class RejectAppointmentsUseCaseContract {
  static inject() => getIt.registerSingleton<RejectAppointmentsUseCaseContract>(
      _RejectAppointmentsUseCase());

  static RejectAppointmentsUseCaseContract get() => getIt<RejectAppointmentsUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider = AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(RejectAppointmentModel appointment);
}




class _RejectAppointmentsUseCase extends RejectAppointmentsUseCaseContract {

  @override
  Future<dynamic> run(RejectAppointmentModel appointment) async {

    return provider.rejectAppointment(appointment);
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