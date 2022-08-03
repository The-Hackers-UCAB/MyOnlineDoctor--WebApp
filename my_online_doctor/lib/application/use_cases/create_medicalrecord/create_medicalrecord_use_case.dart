//Project import:
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/queries/MedicalRecord/MedicalRecord_query_provider_contract.dart';

enum MedicalRecordUseCaseError { noMedicalRecordsFound }

abstract class GetMedicalRecordsUseCaseContract {
  static inject() => getIt.registerSingleton<GetMedicalRecordsUseCaseContract>(
      _GetMedicalRecordsUseCase());

  static GetMedicalRecordsUseCaseContract get() =>
      getIt<GetMedicalRecordsUseCaseContract>();

  /// Providers
  MedicalRecordQueryProviderContract provider =
      MedicalRecordQueryProviderContract.inject();

  /// Methods
  Future<dynamic> run();
}

class _GetMedicalRecordsUseCase extends GetMedicalRecordsUseCaseContract {
  @override
  Future<dynamic> run() async {
    return provider.getMedicalRecords();
  }
}

extension _ProviderMapper on MedicalRecordQueryProviderError {
  MedicalRecordUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return MedicalRecordUseCaseError.noMedicalRecordsFound;
    }
  }
}
