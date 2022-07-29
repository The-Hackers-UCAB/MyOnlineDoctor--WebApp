//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/login_patient/login_patient.dart';

//Project imports
import 'package:my_online_doctor/domain/models/patient/sign_in_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/local_storage/local_storage_provider.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';
part 'login_event.dart';
part 'login_state.dart';


///LoginBloc: Here we would have the Login domain logic.
class LoginBloc extends Bloc<LoginEvent, LoginState> {

  //Here the StreamController can be a state or a DomainModel
  final _loginStreamController = StreamController<bool>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final LoginPatientUseCaseContract _loginPatientUseCase = LoginPatientUseCaseContract.get();



 //Constructor
  //You have to declare the StateInitial as the first state
  LoginBloc() : super(LoginStateInitial()) {
    on<LoginEventFetchBasicData>(_fetchBasicLoginDataEventToState);
    on<LoginEventNavigateTo>(_navigateToEventToState);
    on<LoginEventLoginPatient>(_loginPatientEventToState);

  }


  //Variables:
  String _firebaseToken = '';


  //Getters
  Stream<bool> get streamLogin => _loginStreamController.stream;
  String get firebaseToken => _firebaseToken;


  //Setters


  //Methods:

  ///This method is called when the event is [LoginEventFetchBasicData]
  ///It fetches the basic data of the Login page.
  void _fetchBasicLoginDataEventToState(LoginEvent event, Emitter<LoginState> emit) async {

    emit(LoginStateLoading());

    _firebaseToken = await LocalStorageProvider.readData(RepositoryPathConstant.firebaseToken.path);

    _loadView();
    emit(LoginStateHideLoading());
  }


  ///This method is called when the event is [LoginEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToEventToState(LoginEventNavigateTo event, Emitter<LoginState> emit) {
    _dispose();
    _navigatorManager.navigateTo(event.routeName);
  }


  ///This method is called when the event is [LoginEventLoginPatient]
  ///It logs in the patient.
  void _loginPatientEventToState(LoginEventLoginPatient event, Emitter<LoginState> emit) async {

    emit(LoginStateLoading());

    if( !_loginPatientValidation(event) ) {
      emit(LoginStateHideLoading());
      return;
    }

    final response =  await _loginPatientUseCase.run(event.signInPatientDomainModel);
    
    if (response != null) {

      _dispose();
      _navigatorManager.navigateToWithReplacement('/bottom_menu');
    }

    emit(LoginStateHideLoading());
  }



  //Private methods:


  ///This method is called when the event is [LoginEventLoginPatient]
  ///It validates the login patient.
  bool _loginPatientValidation(LoginEventLoginPatient event) {

    if (!event.isFormValidated) {
      _showDialog(TextConstant.errorTitle.text, TextConstant.errorFormValidation.text);
      return false;

    } 

    return true;
  }

  //To load the view:
  void _loadView() => _loginStreamController.sink.add(true);


  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    return await AppUtil.showDialogUtil(
      context: getIt<ContextManager>().context, 
      title: textTitle, 
      message: textQuestion);

  }


  //To dispose the stream:
  void _dispose() {
    _loginStreamController.close();
  }


}