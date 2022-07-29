import 'package:my_online_doctor/domain/models/patient/sign_in_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class PatientQueryProviderContract<T> {
  static PatientQueryProviderContract inject() => _PatientQueryProvider();

  Future<void> loginPatient(T patient);
  Future<void> logoutPatient();
}

enum PatientQueryProviderError {
  unauthorized,
  internalError,
  patientAlreadyRegistered,
}

class _PatientQueryProvider
    extends PatientQueryProviderContract<SignInPatientDomainModel> {
  @override
  Future<dynamic> loginPatient(SignInPatientDomainModel patient) async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationPost.key,
            endpoint: RepositoryPathConstant.login.path,
            body: patient.toJson())
        .catchError((onError) {
      return null;
    });

    return response;
  }

  @override
  Future<dynamic> logoutPatient() async {
    final response = await getIt<RepositoryManager>()
        .request(
            operation: RepositoryConstant.operationGet.key,
            endpoint: RepositoryPathConstant.logout.path)
        .catchError((onError) {
      return null;
    });

    return response;
  }
}
