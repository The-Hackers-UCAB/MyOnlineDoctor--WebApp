//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/Doctor/Doctor_query_provider_contract.dart';

enum DoctorUseCaseError { noDoctorsFound }

abstract class GetDoctorsUseCaseContract {
  static inject() =>
      getIt.registerSingleton<GetDoctorsUseCaseContract>(_GetDoctorsUseCase());

  static GetDoctorsUseCaseContract get() => getIt<GetDoctorsUseCaseContract>();

  /// Providers
  DoctorQueryProviderContract provider = DoctorQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run(Map<String, dynamic>? filter);
}

class _GetDoctorsUseCase extends GetDoctorsUseCaseContract {
  @override
  Future<dynamic> run(Map<String, dynamic>? filter) async {
    return provider.getDoctors(filter);
  }
}

extension _ProviderMapper on DoctorQueryProviderError {
  DoctorUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return DoctorUseCaseError.noDoctorsFound;
    }
  }
}
