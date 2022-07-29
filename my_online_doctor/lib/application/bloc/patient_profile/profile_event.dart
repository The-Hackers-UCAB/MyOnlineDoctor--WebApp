//Project imports:
part of 'profile_bloc.dart';

///LoginEvent: Here we define the events of the LoginBloc.
abstract class ProfileEvent {}


class ProfileEventNavigateToWith extends ProfileEvent {
  final String routeName;
  ProfileEventNavigateToWith(this.routeName);
}
