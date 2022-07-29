//Project imports:
part of 'doctor_bloc.dart';

//DoctorState: Here we define the states of the DoctorBloc.
abstract class DoctorState {}

class DoctorStateInitial extends DoctorState {}

class DoctorStateLoading extends DoctorState {}

class DoctorStateHideLoading extends DoctorState {}

class DoctorStateDataFetched extends DoctorState {}


