//Project imports:
part of 'profile_bloc.dart';

//LoginState: Here we define the states of the LoginBloc.
abstract class ProfileState {}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateHideLoading extends ProfileState {}

class ProfileStateSuccess extends ProfileState {}

