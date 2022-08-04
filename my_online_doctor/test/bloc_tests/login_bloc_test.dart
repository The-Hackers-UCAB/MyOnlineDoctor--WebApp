import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_online_doctor/application/bloc/login/login_bloc.dart';
import 'package:my_online_doctor/application/bloc/medical_history/medical_history_bloc.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

import '../object_mothers/patient_object_mother.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    InjectionManager.setupInjectionsTesting();
  });

  blocTest(
    'Login bloc test',
    build: () {
      return LoginBloc();
    },
    act: (LoginBloc bloc) {
      bloc.add(LoginEventFetchBasicData());
    },
    expect: () => [
      isInstanceOf<LoginStateLoading>(),
    ],
  );
}
