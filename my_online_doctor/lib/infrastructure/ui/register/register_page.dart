//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//Prokect imports:
import 'package:my_online_doctor/application/bloc/register/register_bloc.dart';
import 'package:my_online_doctor/domain/models/patient/sign_up_patient_domain_model.dart';
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



class RegisterPage extends StatelessWidget {
  
  static const routeName = '/register';

  RegisterPage({Key? key}) : super(key: key);


  //Controllers

  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textEmailController = TextEditingController();
  final TextEditingController _textFirstNameController = TextEditingController();
  final TextEditingController _textSecondNameController = TextEditingController();
  final TextEditingController _textSecondLastNameController = TextEditingController();
  final TextEditingController _textFirstLastNameController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  final TextEditingController _textConfirmPasswordController = TextEditingController();
  final TextEditingController _textPhoneController = TextEditingController();
  final TextEditingController _textBirthdayController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
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
  PreferredSizeWidget _renderAppBar(BuildContext context) => 
    AppBar(
      backgroundColor: colorPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.read<RegisterBloc>().add(RegisterEventNavigateTo('/login'))
      ),
      // leading: renderLogoImageView(context),
      title: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text('Registro de Paciente'),
      )
    );


  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => 
    Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.05, color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, RegisterState state) {
    
    if(state is RegisterStateInitial) {
      context.read<RegisterBloc>().add(RegisterEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! RegisterStateInitial) _registerStreamBuilder(context),
        if(state is RegisterStateInitial || state is RegisterStateLoading) const LoadingComponent(),
        // if(state is RegisterStateSuccess) LoginPage(),
      ],
    );
  }


  //StreamBuilder for the Register Page
  Widget _registerStreamBuilder(BuildContext builderContext) => StreamBuilder<bool>(
    stream: builderContext.read<RegisterBloc>().streamRegister,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

      if(snapshot.hasData) {
        return _registerRenderView(context);
      } 

      return const LoadingComponent();
    }
  );


  //Widget to create the stack of fields
  Widget _registerRenderView(BuildContext context) {

    return  Stack(
        children: [
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: generalMarginView,
                child: Container(
                  child: _createRegisterFields(context)
                ),
              ),
            ),
          ),
        ],
    );
  }


  //Widget to create the fields 
  Widget _createRegisterFields(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:  CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      renderLogoImageView(context),
      _renderPatientEmailTextField(),
      heightSeparator(context, 0.045),
      _renderPatientFirstNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientSecondNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientFirstLastNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientSecondLastNameTextField(),
      heightSeparator(context, 0.045),
      _renderPatientGenreDropdown(context),
      heightSeparator(context, 0.045),
      _renderPatientBirthDateFields(context),
      heightSeparator(context, 0.045),
      _renderPatientPhoneTextField(context),
      heightSeparator(context, 0.045),
      _renderPatientPasswordTextField(),
      heightSeparator(context, 0.045),
      _renderPatientConfirmPasswordTextField(),
      heightSeparator(context, 0.045),
      _renderPatientTermsAndConditionsCheckbox(context),
      heightSeparator(context, 0.045),
      

      _renderRegisterButton(context),
    ],
  );


  Widget _renderPatientEmailTextField() => TextFieldBaseComponent(
    hintText: 'Correo Electrónico', 
    errorMessage: 'Ingrese el correo', 
    minLength: MinMaxConstant.minLengthEmail.value, 
    maxLength: MinMaxConstant.maxLengthEmail.value, 
    textEditingController: _textEmailController, 
    keyboardType: TextInputType.emailAddress,
  );


  Widget _renderPatientFirstNameTextField() => TextFieldBaseComponent(
    hintText: 'Primer Nombre', 
    errorMessage: 'Ingrese el nombre', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textFirstNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientSecondNameTextField() => TextFieldBaseComponent(
    hintText: 'Segundo Nombre', 
    errorMessage: 'Ingrese el nombre', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textSecondNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientFirstLastNameTextField() => TextFieldBaseComponent(
    hintText: 'Primer Apellido', 
    errorMessage: 'Ingrese el apellido', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textFirstLastNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientSecondLastNameTextField() => TextFieldBaseComponent(
    hintText: 'Segundo Apellido', 
    errorMessage: 'Ingrese el apellido', 
    minLength: MinMaxConstant.minLengthName.value, 
    maxLength: MinMaxConstant.maxLengthName.value, 
    textEditingController: _textSecondLastNameController, 
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientGenreDropdown(BuildContext context){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DropdownComponent(
              model: DropdownComponentModel(
                dropDownLists: context.read<RegisterBloc>().genresList.map((e) => e).toList(),
                itemDropdownSelected: context.read<RegisterBloc>().genreSelected!,
                ),
              didChangeValue: (newValue) => context.read<RegisterBloc>().genreSelected = newValue,
            ),
          )
        )
      ],
    );
  }


  Widget _renderPatientPasswordTextField() => TextFieldBaseComponent(
    hintText: 'Contraseña', 
    errorMessage: 'Ingrese la contraseña', 
    minLength: MinMaxConstant.minLengthPassword.value, 
    maxLength: MinMaxConstant.maxLengthPassword.value, 
    textEditingController: _textPasswordController, 
    obscureText: true,
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientConfirmPasswordTextField() => TextFieldBaseComponent(
    hintText: 'Confirmar Contraseña', 
    errorMessage: 'Ingrese la contraseña', 
    minLength: MinMaxConstant.minLengthPassword.value, 
    maxLength: MinMaxConstant.maxLengthPassword.value, 
    textEditingController: _textConfirmPasswordController, 
    obscureText: true,
    keyboardType: TextInputType.text,
  );


  Widget _renderPatientPhoneTextField(BuildContext context){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownComponent(
              model: DropdownComponentModel(
                dropDownLists: context.read<RegisterBloc>().phonesList.map((e) => e).toList(),
                itemDropdownSelected: context.read<RegisterBloc>().phoneSelected!,
                ),
              didChangeValue: (newValue) => context.read<RegisterBloc>().phoneSelected = newValue,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormFieldBaseComponent(
            hintText: 'Teléfono',
            errorMessage: 'Ingrese teléfono',
            maxLength: MinMaxConstant.minLengthPhone.value,
            minLength: MinMaxConstant.maxLengthPhone.value,
            textEditingController: _textPhoneController,
            keyboardType: TextInputType.number,
            validateSpaces: true,
          ),
        ),
      ],
    );
  }


  Widget _renderPatientBirthDateFields(BuildContext context){

    double width = MediaQuery.of(context).size.width * 0.8;
    String spaces = '';

    for(int i =  0; i < width~/20; i++){
      spaces += ' ';
    }

    _textBirthdayController.text = spaces + DateFormat('yyyy-MM-dd').format(context.read<RegisterBloc>().birthDate);

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
              textEditingController: _textBirthdayController,
              enabled: false,
              keyboardType: TextInputType.number,
              isDate: true,
              ),
         ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon( Icons.calendar_month, size: 32),
            color: colorPrimary,
            onPressed: () async{
              final DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                        primaryColor: colorPrimary,
                        colorScheme: const ColorScheme.light(primary:  colorPrimary),
                        buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary
                        ),
                    ),
                    child: child!,
                  );
                },
              );

              // ignore: use_build_context_synchronously
              if(newDate != null) context.read<RegisterBloc>().birthDate = newDate;
              
            },
          ),
          ),
      ],

    );
    
  }


  Widget _renderPatientTermsAndConditionsCheckbox(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: context.read<RegisterBloc>().termsAndConditionsSelected,
          onChanged: (value) => context.read<RegisterBloc>().termsAndConditionsSelected = value!,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'He leído y estoy de acuerdo con los',
                    style: textStyleFormField(false),
                  ),
              ]),
            ),
            RichText(
              text: TextSpan(
                text: 'Términos y Condiciones',
                style: textStyleFormField(true),
                // recognizer: TapGestureRecognizer()..onTap = _launchURL,
              ),
            )
        ])
      ],
    );
  }




  Widget _renderRegisterButton(BuildContext context) => Container(
    width: double.infinity,
    child: ButtonComponent(
      title: 'Registrar',
      style: ButtonComponentStyle.primary,
      actionButton: () => _registerPatient(context),
    )
  );


  void _registerPatient(BuildContext context){

    getIt<ContextManager>().context = context;

    var signUpPatientDomainModel = SignUpPatientDomainModel(
      dto: Dto(
        firstName: _textFirstNameController.text.trim(),
        middleName: _textSecondNameController.text.trim(),
        firstSurname: _textFirstLastNameController.text.trim(),
        secondSurname: _textSecondLastNameController.text.trim(),
        allergies: 'A la vida',
        background: 'Falta de sueño por desarrollo',
        birthdate: DateFormat('yyyy-MM-dd').format(context.read<RegisterBloc>().birthDate),
        height: '1.85',
        phoneNumber: '424123',
        // phoneNumber: context.read<RegisterBloc>().phoneSelected! + _textPhoneController.text,
        weight: '85',
        status: 'Activo',
        surgeries: '3 cirugías',
        gender: context.read<RegisterBloc>().genreSelected == 'Hombre' ? 'M' : 'F',
      ),
      createUserDto: CreateUserDto(
        email: _textEmailController.text.trim(),
        password: _textPasswordController.text.trim(),
      )
      
    );

    getIt<ContextManager>().context = context;

    context.read<RegisterBloc>().add(RegisterEventRegisterPatient(
      signUpPatientDomainModel, 
      _textConfirmPasswordController.text.trim(),
     _formKey.currentState?.validate() ?? false,
     ));
  }





}