//Package imports:
import 'package:flutter/material.dart';
import 'package:my_online_doctor/domain/models/appointment/get_medical_record_model.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';
import 'package:my_online_doctor/infrastructure/ui/appointment/appointment_detail_page.dart';
import 'package:my_online_doctor/infrastructure/ui/appointment/view_appointments_page.dart';
import 'package:my_online_doctor/infrastructure/ui/components/bottom_menu_component.dart';
import 'package:my_online_doctor/infrastructure/ui/doctor_medical_records/medical_record_detail_page.dart';
import 'package:my_online_doctor/infrastructure/ui/doctor_medical_records/view_medical_records_page.dart';
import 'package:my_online_doctor/infrastructure/ui/doctors/search_doctor_page.dart';
import 'package:my_online_doctor/infrastructure/ui/doctors/doctor_page.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/login/login_page.dart';
import 'package:my_online_doctor/infrastructure/ui/logout/logout_page.dart';
import 'package:my_online_doctor/infrastructure/ui/patient/patient_detail_page.dart';
import 'package:my_online_doctor/infrastructure/ui/patient/search_patient_page.dart';
import 'package:my_online_doctor/infrastructure/ui/patient_profile/patient_profile_page.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';
import 'package:my_online_doctor/infrastructure/ui/video_call/call.dart';

///RoutesManager: Class that manages the routes.
class RoutesManager {
  static Route getOnGenerateRoute(RouteSettings settings, {Object? arguments}) {
    switch (settings.name) {
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (context) => RegisterPage());

      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case ViewAppointmentsPage.routeName:
        return MaterialPageRoute(builder: (context) => ViewAppointmentsPage());

      case SearchDoctorPage.routeName:
        return MaterialPageRoute(builder: (context) => SearchDoctorPage());

      case SearchPatientPage.routeName:
        return MaterialPageRoute(builder: (context) => SearchPatientPage());

      case DoctorPage.routeName:
        return MaterialPageRoute(
            builder: (context) => DoctorPage(
                  doctor: arguments as DoctorRequestModel,
                ));

      case PatientDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => PatientDetailPage(
                  patient: arguments as PatientRequestModel,
                ));

      case PatientProfilePage.routeName:
        return MaterialPageRoute(builder: (context) => PatientProfilePage());

      case BottomMenuComponent.routeName:
        return MaterialPageRoute(
            builder: (context) => BottomMenuComponent(
                  items: const [
                    Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    Icon(Icons.event, size: 30),
                    Icon(Icons.person_search, size: 30),
                    Icon(Icons.contacts, size: 30),
                    Icon(Icons.logout_sharp, size: 30),
                  ],
                  screens: [
                    ViewMedicalRecordsPage(),
                    ViewAppointmentsPage(),
                    SearchDoctorPage(),
                    SearchPatientPage(),
                    LogoutPage(),
                  ],
                  index: arguments != null ? arguments as int : 1,
                ));

      case LogoutPage.routeName:
        return MaterialPageRoute(builder: (context) => LogoutPage());

      case CallPage.routeName:
        return MaterialPageRoute(
            builder: (context) => CallPage(
                  channelName: arguments! as String,
                ));

      case AppointmentDetailPage.routeName:
        return MaterialPageRoute(
            builder: (context) => AppointmentDetailPage(
                appointment: arguments! as RequestAppointmentModel));

      case ViewMedicalRecordsPage.routeName:
        return MaterialPageRoute(builder: (context) => ViewAppointmentsPage());

      case MedicalRecord.routeName:
        return MaterialPageRoute(
            builder: (context) => MedicalRecord(
                  record: arguments! as GetMedicalRecordModel,
                ));

      default:
        return MaterialPageRoute(builder: (context) => LoginPage());
    }
  }
}
