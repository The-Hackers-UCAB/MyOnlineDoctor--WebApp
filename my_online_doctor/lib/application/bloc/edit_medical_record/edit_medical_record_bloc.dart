// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_online_doctor/application/use_cases/medical_record/edit_medical_record_use_case.dart';
// import 'package:my_online_doctor/domain/models/appointment/get_medical_record_model.dart';
// import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
// part 'edit_medical_record_event.dart';
// part 'edit_medical_record_state.dart';

// ///RegisterBloc: Here we would have the register domain logic.
// class RegisterBloc extends Bloc<EditRecordEvent, RecordEditState> {
//   //Here the StreamController can be a state or a DomainModel
//   final _editMedicalRecordStreamController = StreamController<bool>();

//   //Instances of use cases:
//   // final GetPhonesUseCaseContract _phonesUseCase = GetPhonesUseCaseContract.get();
//   // final GetGenreUseCaseContract _genreUseCase = GetGenreUseCaseContract.get();
//   final EditMedicalRecordUseCaseContract _registerPatientUseCase =
//       EditMedicalRecordUseCaseContract.get();
//   final NavigatorServiceContract _navigatorManager =
//       NavigatorServiceContract.get();

//   //Variables:

//   String? _description;
//   String? _diagnostic;
//   String? _exams;
//   String? _recipe;
//   String? _planning;


//   //Constructor
//   //You have to declare the StateInitial as the first state
//   RegisterBloc() : super(RecordEditStateInitial()) {
//     on<EditMedicalEventFetchBasicData>(_fetchBasicRegisterDataEventToState);
//     on<EditMedicalEventNavigateTo>(_navigateToEventToState);
//     on<EditMedicalEventEditMedicalPatient>(_editRecordEventToState);
//   }

//   //Getters
//   Stream<bool> get streamRegister => _editMedicalRecordStreamController.stream;
//   String? get description => _description;
//   String? get diagnostic => _diagnostic;
//   String? get exams => _exams;
//   String? get recipe => _recipe;
//   String? get planning => _planning;

//   //Setters
//   // set phoneSelected(String? value) {
//   //   _phoneSelected = value;
//   //   _loadView();
//   // }

//   // set genreSelected(String? value) {
//   //   _genreSelected = value;
//   //   _loadView();
//   // }

//   // set birthDate(DateTime value) {
//   //   _birthDate = value;
//   //   _loadView();
//   // }

//   // set termsAndConditionsSelected(bool value) {
//   //   _termsAndConditionsSelected = value;
//   //   _loadView();
//   // }

//   //Methods:

//   ///This method is called when the event is [RegisterEventFetchBasicData]
//   ///It fetches the basic data of the register page.
//   void _fetchBasicRegisterDataEventToState(
//       EditRecordEvent event, Emitter<RecordEditState> emit) async {
//     emit(RecordEditStateLoading());

//     _setInitalRegisterData();

//     _loadView();

//     emit(RecordEditStateDataFetched());
//   }

//   ///This method is called when the event is [RegisterEventNavigateTo]
//   ///It navigates to the specified page.
//   void _navigateToEventToState(
//       RegisterEventNavigateTo event, Emitter<RegisterState> emit) {
//     _dispose();

//     if (event.routeName == '/login') {
//       _navigatorManager.pop(null);
//     } else {
//       _navigatorManager.navigateTo(event.routeName);
//     }
//   }

//   ///This method is called when the event is [RegisterEventRegisterPatient]
//   ///It registers the patient.
//   void _registerPatientEventToState(
//       RegisterEventRegisterPatient event, Emitter<RegisterState> emit) async {
//     emit(RegisterStateLoading());

//     if (!_registerPatientValidation(event)) {
//       emit(RegisterStateHideLoading());
//       _loadView();
//       return;
//     }

//     final response =
//         await _registerPatientUseCase.run(event.signUpPatientDomainModel);

//     if (response != null) {
//       // ignore: use_build_context_synchronously
//       // _showDialog(TextConstant.successTitle.text, TextConstant.successRegister.text);

//       await showDialog(
//           context: getIt<ContextManager>().context,
//           builder: (BuildContext superContext) => DialogComponent(
//                 textTitle: TextConstant.successTitle.text,
//                 textQuestion: TextConstant.successRegister.text,
//               ));
//       emit(RegisterStateHideLoading());
//       // emit(RegisterStateSuccess());
//       _loadView();

//       _dispose();

//       _navigatorManager.pop(null);
//       _navigatorManager.navigateToWithReplacement('/login');
//     }
//   }

//   //Private methods:

//   ///This method is called when the event is [RegisterEventRegisterPatient]
//   ///It validates the patient data.
//   bool _registerPatientValidation(RegisterEventRegisterPatient event) {
//     if (!event.isFormValidated) {
//       _showDialog(
//           TextConstant.errorTitle.text, TextConstant.errorFormValidation.text);
//       return false;
//     }

//     if (!_termsAndConditionsSelected) {
//       _showDialog(TextConstant.errorTitle.text,
//           TextConstant.termsAndConditionsNotSelected.text);
//       return false;
//     }

//     if (event.signUpPatientDomainModel.createUserDto.password !=
//         event.confirmPassword) {
//       _showDialog(
//           TextConstant.errorTitle.text, TextConstant.passwordNotMatch.text);
//       return false;
//     }

//     if (_birthDate
//         .isAfter(DateTime.now().subtract(const Duration(days: 365 * 18)))) {
//       _showDialog(
//           TextConstant.errorTitle.text, TextConstant.birthDateInvalid.text);
//       return false;
//     }

//     return true;
//   }

//   ///This method is called when the event is [RegisterEventFetchBasicData]
//   ///It sets the initial data of the register page.
//   void _setInitalRegisterData() {
//     _phoneSelected = _phonesList.first;
//     _genreSelected = _genresList.first;
//   }

//   //To load the view:
//   void _loadView() => _registerStreamController.sink.add(true);

//   //To show the dialog:
//   void _showDialog(String textTitle, String textQuestion) async {
//     var newContext = getIt<ContextManager>().context;

//     return await showDialog(
//         context: newContext,
//         builder: (BuildContext dialogContext) =>
//             Builder(builder: (superContext) {
//               return DialogComponent(
//                 textTitle: textTitle,
//                 textQuestion: textQuestion,
//               );
//             }));
//   }

//   void _dispose() {
//     _registerStreamController.close();
//   }
// }
