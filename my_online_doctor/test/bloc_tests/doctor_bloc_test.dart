import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_online_doctor/application/bloc/doctor/doctor_bloc.dart';

import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

void main() {
  setUpAll(() {
    InjectionManager.setupInjectionsTesting();
  });

  blocTest(
    'Doctor bloc',
    build: () {
      return DoctorBloc();
    },
    act: (DoctorBloc bloc) {
      bloc.add(DoctorEventFetchBasicData());
    },
    expect: () => [
      isInstanceOf<DoctorStateLoading>(),
      isInstanceOf<DoctorStateHideLoading>()
    ],
  );
}
