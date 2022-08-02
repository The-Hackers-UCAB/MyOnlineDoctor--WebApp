//Project import:
import 'package:my_online_doctor/domain/models/appointment/complete_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError { noAppointmentsFound }

abstract class CompleteAppointmentUseCaseContract {
  static inject() =>
      getIt.registerSingleton<CompleteAppointmentUseCaseContract>(
          _CompleteAppointmentUseCase());

  static CompleteAppointmentUseCaseContract get() =>
      getIt<CompleteAppointmentUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider =
      AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(String appointment);
}

class _CompleteAppointmentUseCase extends CompleteAppointmentUseCaseContract {
  @override
  Future<dynamic> run(String appointment) async {
    return provider.completeAppointment(appointment);
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
