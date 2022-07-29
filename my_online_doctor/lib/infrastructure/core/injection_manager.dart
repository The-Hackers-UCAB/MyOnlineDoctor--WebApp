// Package imports:
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_online_doctor/application/use_cases/appointments/accept_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/call_patient_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/cancel_appointment_use_case.dart';

// Project imports:
import 'package:my_online_doctor/application/use_cases/appointments/get_appointments_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/reject_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/schedule_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/doctors/get_doctors_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/login_patient/login_patient.dart';
import 'package:my_online_doctor/application/use_cases/logout_patient/logout_patient.dart';
import 'package:my_online_doctor/application/use_cases/register_patient/register_patient_use_case.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/local_storage/local_storage_provider.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';
import 'package:my_online_doctor/infrastructure/ui/video_call/call.dart';

final getIt = GetIt.instance;

Future<void> backgroundHandler(RemoteMessage message) async {

    var context = getIt<ContextManager>().context;

        var response = await showDialog(
            context: context,
            builder: (BuildContext dialogContext) => const DialogComponent(
                textTitle: 'Cita médica',
                textQuestion: 'Desea atenter su llamada?',
                cancelButton: true));


      if (response != null && response) {

        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (buildContext) => CallPage(
                channelName: message.data['payload']['channelName'],
                role: ClientRole.Broadcaster,
              ),
            ),
          );
      }

 


  // final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  // _navigatorManager.navigateToWithReplacement('/bottom_menu');
  print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
  print('backgroundHandler: ${message.notification!.title}');
  print('Payload: ${message.data}');
  print('//////////////////////////////////////////////////////////////////////////////////////////////////////');
}

///InjectionManager: Class that manages the injection of dependencies.
class InjectionManager {
  static void setupInjections() async {

    getIt.registerSingleton<ContextManager>(ContextManager());
    getIt.registerSingleton<RepositoryManager>(RepositoryManager());


    NavigatorServiceContract.inject();

    //FIREBASE
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    //Getting the firebase token for the device.
    FirebaseMessaging.instance.getToken().then((token) {

      LocalStorageProvider.saveData(RepositoryPathConstant.firebaseToken.path, token!);

    });


    //USE CASES
    GetPhonesUseCaseContract.inject();
    GetGenreUseCaseContract.inject();
    RegisterPatientUseCaseContract.inject();
    LoginPatientUseCaseContract.inject();
    GetAppointmentsUseCaseContract.inject();
    LogoutPatientUseCaseContract.inject();
    CancelAppointmentsUseCaseContract.inject();
    RejectAppointmentsUseCaseContract.inject();
    AcceptAppointmentsUseCaseContract.inject();
    GetDoctorsUseCaseContract.inject();
    CallPatientUseCaseContract.inject();
    ScheduleAppointmentsUseCaseContract.inject();

  }
}
