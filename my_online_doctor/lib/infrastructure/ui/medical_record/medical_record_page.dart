//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_online_doctor/application/bloc/medical_record/medical_record_bloc.dart';
import 'package:my_online_doctor/domain/models/medicalRecord/medical_record_domain_model.dart';

//Prokect imports:
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dropdown_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_form_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';

class MedicalRecordPage extends StatelessWidget {
  static const routeName = '/medicalrecord';

  final MedicalRecordDomainModel medicalrecord;

  MedicalRecordPage({
    Key? key,
    required this.medicalrecord,
  }) : super(key: key);

  //Controllers

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textDescriptionController =
      TextEditingController();
  final TextEditingController _textDiagnosticController =
      TextEditingController();
  final TextEditingController _textPlanningController = TextEditingController();
  final TextEditingController _textRecipeController = TextEditingController();
  final TextEditingController _textExamController = TextEditingController();
  final TextEditingController _textAppointmentDateController =
      TextEditingController();
  // final TextEditingController _textPasswordController = TextEditingController();
  // final TextEditingController _textConfirmPasswordController = TextEditingController();
  // final TextEditingController _textPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => MedicalRecordBloc(),
      child: BlocBuilder<MedicalRecordBloc, MedicalRecordState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _body(context, state),
            bottomNavigationBar: _renderBottomNavigationBar(context),
          );
        },
      ),
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
      backgroundColor: colorPrimary,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context
              .read<MedicalRecordBloc>()
              .add(MedicalRecordEventNavigateTo('/view_appointments'))),
      // leading: renderLogoImageView(context),
      title: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text('Registro de Historia Medica'),
      ));

  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, MedicalRecordState state) {
    if (state is MedicalRecordStateInitial) {
      context.read<MedicalRecordBloc>().add(MedicalRecordEventFetchBasicData());
    }

    return Stack(
      children: [
        if (state is! MedicalRecordStateInitial)
          _medicalRecordStreamBuilder(context),
        if (state is MedicalRecordStateInitial ||
            state is MedicalRecordStateLoading)
          const LoadingComponent(),
        // if(state is RegisterStateSuccess) LoginPage(),
      ],
    );
  }

  //StreamBuilder for the Medical Record Page
  Widget _medicalRecordStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<bool>(
          stream: builderContext.read<MedicalRecordBloc>().streamMedicalRecord,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return _medicalRecordRenderView(context);
            }

            return const LoadingComponent();
          });

  //Widget to create the stack of fields
  Widget _medicalRecordRenderView(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: generalMarginView,
              child: Container(child: _createMedicalRecordFields(context)),
            ),
          ),
        ),
      ],
    );
  }

  //Widget to create the fields
  Widget _createMedicalRecordFields(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          renderLogoImageView(context),
          _renderMedicalRecordDescriptiomTextField(), //Motivo
          heightSeparator(context, 0.045),
          _renderMedicalRecordDiagnosticTextField(), //Diagnostico
          heightSeparator(context, 0.045),
          _renderMedicalRecordPlanningTextField(), //Plan
          heightSeparator(context, 0.045),
          _renderMedicalRecordRecipeTextField(), //Recipe
          heightSeparator(context, 0.045),
          _renderMedicalRecordExamTextField(), //Exam
          heightSeparator(context, 0.045),
          _renderMedicalRecordDateFields(context), //Fecha
          heightSeparator(context, 0.045),
          // _renderPatientGenreDropdown(context),
          // heightSeparator(context, 0.045),
          // _renderPatientPhoneTextField(context),
          // heightSeparator(context, 0.045),
          // _renderPatientPasswordTextField(),
          // heightSeparator(context, 0.045),
          // _renderPatientConfirmPasswordTextField(),
          // heightSeparator(context, 0.045),
          // _renderPatientTermsAndConditionsCheckbox(context),
          // heightSeparator(context, 0.045),

          _renderRegisterButton(context),
        ],
      );

  Widget _renderMedicalRecordDescriptiomTextField() => TextFieldBaseComponent(
        hintText: 'Motivo',
        errorMessage: 'Ingrese el motivo de la consulta',
        minLength: MinMaxConstant.minLengthEmail.value,
        maxLength: MinMaxConstant.maxLengthEmail.value,
        textEditingController: _textDescriptionController,
        keyboardType: TextInputType.text,
      );

  Widget _renderMedicalRecordDiagnosticTextField() => TextFieldBaseComponent(
        hintText: 'Diagnóstico',
        errorMessage: 'Ingrese el Diagnóstico',
        minLength: MinMaxConstant.minLengthEmail.value,
        maxLength: MinMaxConstant.maxLengthEmail.value,
        textEditingController: _textDiagnosticController,
        keyboardType: TextInputType.text,
      );

  Widget _renderMedicalRecordPlanningTextField() => TextFieldBaseComponent(
        hintText: 'Plan',
        errorMessage: 'Ingrese el Plan',
        minLength: MinMaxConstant.minLengthEmail.value,
        maxLength: MinMaxConstant.maxLengthEmail.value,
        textEditingController: _textPlanningController,
        keyboardType: TextInputType.text,
      );

  Widget _renderMedicalRecordRecipeTextField() => TextFieldBaseComponent(
        hintText: 'Recipe',
        errorMessage: 'Ingrese el Recipe',
        minLength: MinMaxConstant.minLengthEmail.value,
        maxLength: MinMaxConstant.maxLengthEmail.value,
        textEditingController: _textRecipeController,
        keyboardType: TextInputType.text,
      );

  Widget _renderMedicalRecordExamTextField() => TextFieldBaseComponent(
        hintText: 'Examenes',
        errorMessage: 'Ingrese los examenes a realizar',
        minLength: MinMaxConstant.minLengthEmail.value,
        maxLength: MinMaxConstant.maxLengthEmail.value,
        textEditingController: _textExamController,
        keyboardType: TextInputType.text,
      );

  Widget _renderMedicalRecordDateFields(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    String spaces = '';

    for (int i = 0; i < width ~/ 20; i++) {
      spaces += ' ';
    }

    _textAppointmentDateController.text = spaces +
        DateFormat('yyyy-MM-dd').format(context.read<MedicalRecordBloc>().date);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 3,
          child: TextFormFieldBaseComponent(
            errorMessage: null,
            minLength: 0,
            maxLength: 1,
            textEditingController: _textAppointmentDateController,
            enabled: false,
            keyboardType: TextInputType.number,
            isDate: true,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.calendar_month, size: 32),
            color: colorPrimary,
            onPressed: () async {
              final DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now(),
                builder: (BuildContext context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: colorPrimary,
                      colorScheme:
                          const ColorScheme.light(primary: colorPrimary),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              // ignore: use_build_context_synchronously
              if (newDate != null)
                context.read<MedicalRecordBloc>().date = newDate;
            },
          ),
        ),
      ],
    );
  }

  // Widget _renderPatientGenreDropdown(BuildContext context){

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Expanded(
  //         flex: 2,
  //         child: Padding(
  //           padding: const EdgeInsets.only(right: 8),
  //           child: DropdownComponent(
  //             model: DropdownComponentModel(
  //               dropDownLists: context.read<RegisterBloc>().genresList.map((e) => e).toList(),
  //               itemDropdownSelected: context.read<RegisterBloc>().genreSelected!,
  //               ),
  //             didChangeValue: (newValue) => context.read<RegisterBloc>().genreSelected = newValue,
  //           ),
  //         )
  //       )
  //     ],
  //   );
  // }

  // Widget _renderPatientPasswordTextField() => TextFieldBaseComponent(
  //   hintText: 'Contraseña',
  //   errorMessage: 'Ingrese la contraseña',
  //   minLength: MinMaxConstant.minLengthPassword.value,
  //   maxLength: MinMaxConstant.maxLengthPassword.value,
  //   textEditingController: _textPasswordController,
  //   obscureText: true,
  //   keyboardType: TextInputType.text,
  // );

  // Widget _renderPatientConfirmPasswordTextField() => TextFieldBaseComponent(
  //   hintText: 'Confirmar Contraseña',
  //   errorMessage: 'Ingrese la contraseña',
  //   minLength: MinMaxConstant.minLengthPassword.value,
  //   maxLength: MinMaxConstant.maxLengthPassword.value,
  //   textEditingController: _textConfirmPasswordController,
  //   obscureText: true,
  //   keyboardType: TextInputType.text,
  // );

  // Widget _renderPatientPhoneTextField(BuildContext context){

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: <Widget>[
  //       Expanded(
  //         flex: 2,
  //         child: Padding(
  //           padding: const EdgeInsets.only(right: 8.0),
  //           child: DropdownComponent(
  //             model: DropdownComponentModel(
  //               dropDownLists: context.read<RegisterBloc>().phonesList.map((e) => e).toList(),
  //               itemDropdownSelected: context.read<RegisterBloc>().phoneSelected!,
  //               ),
  //             didChangeValue: (newValue) => context.read<RegisterBloc>().phoneSelected = newValue,
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         flex: 3,
  //         child: TextFormFieldBaseComponent(
  //           hintText: 'Teléfono',
  //           errorMessage: 'Ingrese teléfono',
  //           maxLength: MinMaxConstant.minLengthPhone.value,
  //           minLength: MinMaxConstant.maxLengthPhone.value,
  //           textEditingController: _textPhoneController,
  //           keyboardType: TextInputType.number,
  //           validateSpaces: true,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _renderPatientTermsAndConditionsCheckbox(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Checkbox(
  //         checkColor: Colors.white,
  //         value: context.read<RegisterBloc>().termsAndConditionsSelected,
  //         onChanged: (value) => context.read<RegisterBloc>().termsAndConditionsSelected = value!,
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           RichText(
  //             text: TextSpan(
  //               children: [
  //                 TextSpan(
  //                   text: 'He leído y estoy de acuerdo con los',
  //                   style: textStyleFormField(false),
  //                 ),
  //             ]),
  //           ),
  //           RichText(
  //             text: TextSpan(
  //               text: 'Términos y Condiciones',
  //               style: textStyleFormField(true),
  //               // recognizer: TapGestureRecognizer()..onTap = _launchURL,
  //             ),
  //           )
  //       ])
  //     ],
  //   );
  // }

  Widget _renderRegisterButton(BuildContext context) => Container(
      width: double.infinity,
      child: ButtonComponent(
        title: 'Registrar',
        style: ButtonComponentStyle.primary,
        actionButton: () => _registerMedicalRecord(context),
      ));

  void _registerMedicalRecord(BuildContext context) {
    getIt<ContextManager>().context = context;

    var medicalRecordDomainModel = MedicalRecordDomainModel(
      dto: DtoRecord(
        description: _textDescriptionController.text.trim(),
        diagnostic: _textDiagnosticController.text.trim(),
        exams: _textExamController.text.trim(),
        recipe: _textRecipeController.text.trim(),
        planning: _textPlanningController.text.trim(),
        date: DateFormat('yyyy-MM-dd')
            .format(context.read<MedicalRecordBloc>().date),
        //background: 'Falta de sueño por desarrollo',
        //height: '1.85',
        //phoneNumber: '424123',
        // phoneNumber: context.read<RegisterBloc>().phoneSelected! + _textPhoneController.text,
        // weight: '85',
        // status: 'Activo',
        // surgeries: '3 cirugías',
        // gender: context.read<RegisterBloc>().genreSelected == 'Hombre' ? 'M' : 'F',
      ),
      // createUserDto: CreateUserDto(
      //   email: _textDescriptionController.text.trim(),
      //   password: _textPasswordController.text.trim(),
      // )
    );

    // getIt<ContextManager>().context = context;

    // context.read<RegisterBloc>().add(RegisterEventRegisterPatient(
    //   medicalRecordDomainModel,
    //   _textConfirmPasswordController.text.trim(),
    //  _formKey.currentState?.validate() ?? false,
    //  ));
  }
}
