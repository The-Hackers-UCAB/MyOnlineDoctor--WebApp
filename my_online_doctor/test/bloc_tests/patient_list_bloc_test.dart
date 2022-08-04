import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:my_online_doctor/application/bloc/patient_list/patient_list_bloc.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

void main() {
  setUpAll(() {
    InjectionManager.setupInjectionsTesting();
  });

  blocTest(
    'Patient List bloc',
    build: () {
      return PatientListBloc();
    },
    act: (PatientListBloc bloc) {
      bloc.add(FetchBasicData());
    },
    expect: () => [
      isInstanceOf<PatientListLoading>(),
      isInstanceOf<PatientListHideLoading>()
    ],
  );
}
