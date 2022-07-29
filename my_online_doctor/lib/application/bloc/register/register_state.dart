//Project imports:
part of 'register_bloc.dart';

//RegisterState: Here we define the states of the RegisterBloc.
abstract class RegisterState {}

class RegisterStateInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateHideLoading extends RegisterState {}

class RegisterStateDataFetched extends RegisterState {}

class RegisterStateSuccess extends RegisterState {}

