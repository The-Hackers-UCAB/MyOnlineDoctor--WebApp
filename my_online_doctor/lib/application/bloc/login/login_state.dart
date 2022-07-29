//Project imports:
part of 'login_bloc.dart';

//LoginState: Here we define the states of the LoginBloc.
abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateHideLoading extends LoginState {}

class LoginStateSuccess extends LoginState {}

