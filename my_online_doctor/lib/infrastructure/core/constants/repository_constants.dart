
///RepositorysConstant: Enum for repositories methods.
enum RepositoryConstant {
  contentType,
  operationGet,
  operationPost,
  operationPut,
  operationDelete,
}

extension RepositoryConstantExtension on RepositoryConstant {

  String get key {
    switch (this) {
      case RepositoryConstant.contentType:
        return 'application/json';
      case RepositoryConstant.operationGet:
        return 'get';
      case RepositoryConstant.operationPost:
        return 'post';
      case RepositoryConstant.operationPut:
        return 'put';
      case RepositoryConstant.operationDelete:
        return 'delete';
    }
  }
}


///RepositoryPathConstant: Enum for endpoints path.
enum RepositoryPathConstant {
  register,
  login,
  logout,
  getAppointments,
  cookie,
  firebaseToken,
  cancelAppointment,
  rejectAppointment,
  getDoctors,
  getAppointmentsDoctor,
  callPatient,
  scheduleAppointment,
}

extension RepositoryPathConstantExtension on RepositoryPathConstant {

  String get path {

    switch (this) {
      case RepositoryPathConstant.scheduleAppointment:
        return 'api/appointment/schedule';

      case RepositoryPathConstant.register:
        return 'api/patient';

      case RepositoryPathConstant.callPatient:
        return 'api/appointment/call';

      case RepositoryPathConstant.login:
        return 'api/auth/login';

      case RepositoryPathConstant.logout:
        return 'api/auth/logout';

      case RepositoryPathConstant.getAppointments:
        return 'api/patient/appointments?pageIndex=0&pageSize=5';

      case RepositoryPathConstant.getAppointmentsDoctor:
        return 'api/doctor/appointments?pageIndex=0&pageSize=5';

      case RepositoryPathConstant.cookie:
        return 'cookie';

      case RepositoryPathConstant.firebaseToken:
        return 'firebaseToken';

      case RepositoryPathConstant.cancelAppointment:
        return 'api/appointment/cancel/doctor';

      case RepositoryPathConstant.rejectAppointment:
        return 'api/appointment/reject/doctor';

      case RepositoryPathConstant.getDoctors:
        return 'api/doctor/search?pageIndex=0&pageSize=20';

    }
  }
}
