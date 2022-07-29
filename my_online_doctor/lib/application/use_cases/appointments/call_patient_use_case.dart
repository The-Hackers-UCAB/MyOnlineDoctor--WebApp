//Project import:
import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/appointment/appointment_command_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class CallPatientUseCaseContract {
  static inject() => getIt.registerSingleton<CallPatientUseCaseContract>(
      _CallPatientUseCase());

  static CallPatientUseCaseContract get() => getIt<CallPatientUseCaseContract>();

  /// Providers
  AppointmentCommandProviderContract provider = AppointmentCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(AcceptAppointmentModel appointment);
}




class _CallPatientUseCase extends CallPatientUseCaseContract {

  @override
  Future<dynamic> run(AcceptAppointmentModel appointment) async {

    return provider.callAppointment(appointment);
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