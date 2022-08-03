// Package imports
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/flavor_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/core/routes_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/login/login_page.dart';
import 'package:my_online_doctor/infrastructure/ui/medical_record/medical_record_page.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';
import 'package:my_online_doctor/infrastructure/utils/device_util.dart';

import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

//This the main function of the app.
void main() async {
  InjectionManager.setupInjections(); //Here we setup the injections.

  WidgetsFlutterBinding.ensureInitialized();
  var test = await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  FlavorManager.make(Flavor.PRODUCTION);
  runApp(const MyOnlineDoctorApp()); //Here we run the app.
}

///MyOnlineDoctorApp: Class that manages the app.
class MyOnlineDoctorApp extends StatelessWidget {
  const MyOnlineDoctorApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    getIt<ContextManager>().context = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorServiceContract.get().navigatorKey,
      theme: mainTheme(),
      onGenerateRoute: (
        RouteSettings settings,
      ) =>
          RoutesManager.getOnGenerateRoute(settings,
              arguments: settings.arguments),
      home: MedicalRecordPage(),
    );
  }

  Widget _checkInternet() {
    return FutureBuilder(
      future: DeviceUtil.checkInternetConnection(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            _requestCallPermisions();
            return LoginPage();
            //TO DO: Add the home page.
            // return HomePage();
          } else {
            return const CircularProgressIndicator(color: Colors.blue);
            //TO DO: Add the error page. (No Internet)
            // return NoInternetPage();
          }
        } else {
          return const LoadingComponent();
        }
      },
    );
  }

  Future _requestCallPermisions() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status.toString());
  }
}
