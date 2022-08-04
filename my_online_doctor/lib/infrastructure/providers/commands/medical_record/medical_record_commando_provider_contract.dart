import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class MedicalRecordCommandProviderContract {
  static MedicalRecordCommandProviderContract inject() =>
      _MedicalRecordCommandProvider();

  Future<void> editDescription(String description, String id);

  Future<void> editDiagnostic(String diagnostic, String id);

  Future<void> editExams(String exams, String id);

  Future<void> editRecipe(String recipe, String id);

  Future<void> editPlanning(String planning, String id);
}

enum MedicalRecordCommandProviderError {
  unauthorized,
  internalError,
}

class _MedicalRecordCommandProvider
    extends MedicalRecordCommandProviderContract {
  @override
  Future<dynamic> editDescription(String description, String id) async {
    final response = await getIt<RepositoryManager>().request(
        operation: RepositoryConstant.operationPost.key,
        endpoint: RepositoryPathConstant.editDescription.path,
        body: {'id': id, 'description': description}).catchError((onError) {
      return null;
    });
    return response;
  }

  @override
  Future<dynamic> editDiagnostic(String diagnostic, String id) async {
    final response = await getIt<RepositoryManager>().request(
        operation: RepositoryConstant.operationPost.key,
        endpoint: RepositoryPathConstant.editDiagnostic.path,
        body: {'id': id, 'diagnostic': diagnostic}).catchError((onError) {
      return null;
    });
    return response;
  }

  @override
  Future<dynamic> editExams(String exams, String id) async {
    final response = await getIt<RepositoryManager>().request(
        operation: RepositoryConstant.operationPost.key,
        endpoint: RepositoryPathConstant.editExams.path,
        body: {'id': id, 'exams': exams}).catchError((onError) {
      return null;
    });
    return response;
  }

  @override
  Future<dynamic> editRecipe(String recipe, String id) async {
    final response = await getIt<RepositoryManager>().request(
        operation: RepositoryConstant.operationPost.key,
        endpoint: RepositoryPathConstant.editRecipe.path,
        body: {'id': id, 'recipe': recipe}).catchError((onError) {
      return null;
    });
    return response;
  }

  @override
  Future<dynamic> editPlanning(String planning, String id) async {
    final response = await getIt<RepositoryManager>().request(
        operation: RepositoryConstant.operationPost.key,
        endpoint: RepositoryPathConstant.editPlanning.path,
        body: {'id': id, 'planning': planning}).catchError((onError) {
      return null;
    });
    return response;
  }
}
