//Project import:
import 'package:my_online_doctor/domain/models/patient/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/domain/models/appointment/get_medical_record_model.dart';
import 'package:my_online_doctor/infrastructure/providers/commands/medical_record/medical_record_commando_provider_contract.dart';

enum EditMedicalRecordUseCaseError { error }

abstract class EditMedicalRecordUseCaseContract {
  static inject() => getIt.registerSingleton<EditMedicalRecordUseCaseContract>(
      _EditMedicalRecordUseCase());

  static EditMedicalRecordUseCaseContract get() =>
      getIt<EditMedicalRecordUseCaseContract>();

  /// Providers
  MedicalRecordCommandProviderContract provider =
      MedicalRecordCommandProviderContract.inject();

  /// Methods
  Future<dynamic> run(GetMedicalRecordModel record);
}

class _EditMedicalRecordUseCase extends EditMedicalRecordUseCaseContract {
  @override
  Future<dynamic> run(GetMedicalRecordModel record) async {
    return provider.editDescription(record.description, record.id);
  }
}

extension _ProviderMapper on EditMedicalRecordUseCaseError {
  EditMedicalRecordUseCaseError toUseCaseError() {
    switch (this) {
      default:
        return EditMedicalRecordUseCaseError.error;
    }
  }
}
