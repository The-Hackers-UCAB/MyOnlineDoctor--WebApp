//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/Appointment/Appointment_query_provider_contract.dart';

enum AppointmentUseCaseError {noAppointmentsFound }


abstract class GetAppointmentsUseCaseContract {
  static inject() => getIt.registerSingleton<GetAppointmentsUseCaseContract>(
      _GetAppointmentsUseCase());

  static GetAppointmentsUseCaseContract get() => getIt<GetAppointmentsUseCaseContract>();

  /// Providers
  AppointmentQueryProviderContract provider = AppointmentQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run();
}




class _GetAppointmentsUseCase extends GetAppointmentsUseCaseContract {

  @override
  Future<dynamic> run() async {

    return provider.getAppointments();
  }
}


extension _ProviderMapper on AppointmentQueryProviderError {
  AppointmentUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return AppointmentUseCaseError.noAppointmentsFound;
    }
  }
}