//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/use_cases/appointments/get_appointments_use_case.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';
part 'appointment_event.dart';
part 'appointment_state.dart';


///AppointmentBloc: Here we would have the Appointment domain logic.
class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {

  //Here the StreamController can be a state or a DomainModel
  final _appointmentStreamController = StreamController<List<RequestAppointmentModel>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final GetAppointmentsUseCaseContract _getAppointmentUseCase = GetAppointmentsUseCaseContract.get();


  //Constructor
  //You have to declare the StateInitial as the first state
  AppointmentBloc() : super(AppointmentStateInitial()) {
    on<AppointmentEventFetchBasicData>(_fetchBasicAppointmentDataEventToState);
    on<AppointmentEventNavigateToWith>(_navigateToWithEventToState);
  }


  //Getters
  Stream<List<RequestAppointmentModel>> get streamAppointment => _appointmentStreamController.stream;


  //Setters


  //Methods:

  ///This method is called when the event is [AppointmentEventFetchBasicData]
  ///It fetches the basic data of the Appointment page.
  void _fetchBasicAppointmentDataEventToState(AppointmentEvent event, Emitter<AppointmentState> emit) async {

    emit(AppointmentStateLoading());

    var response = await _getAppointmentUseCase.run();


    if(response != null) {

      var appointmentList = response.map((e) => requestAppointmentModelFromJson(e)).toList();

      List<RequestAppointmentModel> appointments = appointmentList.cast<RequestAppointmentModel>();

      _appointmentStreamController.sink.add(appointments);

    } else {

      _appointmentStreamController.sink.add([]);

    }



    emit(AppointmentStateHideLoading());
  }



  ///This method is called when the event is [AppointmentEventNavigateToWith]
  ///It navigates to the specified page.
  void _navigateToWithEventToState(AppointmentEventNavigateToWith event, Emitter<AppointmentState> emit) async {
    _dispose();
    _navigatorManager.navigateToWithReplacement(event.routeName, arguments: event.arguments);
  }








  //Private methods:

  //To load the view:
  // void _loadView() => _appointmentStreamController.sink.add(true);


  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    return await AppUtil.showDialogUtil(
      context: getIt<ContextManager>().context, 
      title: textTitle, 
      message: textQuestion);

  }


  void _dispose(){
    _appointmentStreamController.close();
  }


}