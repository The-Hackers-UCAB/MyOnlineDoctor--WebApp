//Package imports:
import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';

// import '../../../infrastructure/ui/components/dialog_component.dart';
part 'profile_event.dart';
part 'profile_state.dart';


///LoginBloc: Here we would have the Login domain logic.
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  // Here the StreamController can be a state or a DomainModel
  final _profileStreamController = StreamController<bool>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();

 //Constructor
  //You have to declare the StateInitial as the first state
  ProfileBloc() : super(ProfileStateInitial()) {
    on<ProfileEventNavigateToWith>(_navigateToWithEventToState);

  }
  //Getters
  Stream<bool> get streamLogin => _profileStreamController.stream;

  //Methods:
  ///This method is called when the event is [ProfileEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(ProfileEventNavigateToWith event, Emitter<ProfileState> emit) {

    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName);
  }


  //Private methods:

  void _dispose() {
    _profileStreamController.close();
  }

}