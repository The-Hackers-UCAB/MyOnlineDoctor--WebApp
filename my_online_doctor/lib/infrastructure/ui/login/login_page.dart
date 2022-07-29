//Package imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//Project imports:
import 'package:my_online_doctor/application/bloc/login/login_bloc.dart';
import 'package:my_online_doctor/domain/models/patient/sign_in_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/components/text_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';



class LoginPage extends StatelessWidget {

  static const routeName = '/login';

  LoginPage({Key? key}) : super(key: key);


  //Controllers

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _textEmailController = TextEditingController(text: 'doctor@email.com');
  final TextEditingController _textPasswordController = TextEditingController(text: '12345678');




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
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
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( backgroundColor: colorPrimary);

  
  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => 
    Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.05, color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, LoginState state) {
    
    if(state is LoginStateInitial) {
      context.read<LoginBloc>().add(LoginEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! LoginStateInitial)  _loginStreamBuilder(context),
        if(state is LoginStateInitial || state is LoginStateLoading) const LoadingComponent(),
      ],
    );
  }


  //StreamBuilder for the Login Page
  Widget _loginStreamBuilder(BuildContext builderContext) => StreamBuilder<bool>(
    stream: builderContext.read<LoginBloc>().streamLogin,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

      if(snapshot.hasData) {
        return _loginRenderView(context);
      } 

      return const LoadingComponent();
    }
  );


    //Widget to create the stack of fields
  Widget _loginRenderView(BuildContext context) {

    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: generalMarginView,
              child: Container(
                child: _createLoginFields(context)
              ),
            ),
          ),
        ),
      ],
    );
  }


//Widget to create the fields 
  Widget _createLoginFields(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment:  CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      renderLogoImageView(context, fullLogo: true),
      _renderPatientEmailTextField(),
      heightSeparator(context, 0.035),
      _renderPatientPasswordTextField(),
      heightSeparator(context, 0.025),
      _renderButtons(context),
      heightSeparator(context, 0.025),
      _renderForgotPassword(context),
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

  Widget _renderPatientPasswordTextField() => TextFieldBaseComponent(
    hintText: 'Contraseña', 
    errorMessage: 'Ingrese la contraseña', 
    minLength: MinMaxConstant.minLengthPassword.value, 
    maxLength: MinMaxConstant.maxLengthPassword.value, 
    textEditingController: _textPasswordController, 
    obscureText: true,
    keyboardType: TextInputType.text,
  );


  Widget _renderButtons(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 5),
    child: Center(
      child: Column(
        children: [
          _renderSignInButton(context), 
          _renderRegisterButton(context)
        ],
        )
      )
    );


  Widget _renderSignInButton(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 5),
    width: double.infinity,
    child:  ButtonComponent(
      title: TextConstant.signIn.text,
      actionButton:  () => _signIn(context),
    )
  );


  Widget _renderRegisterButton(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 5),
    width: double.infinity,
    child: ButtonComponent(
      title: TextConstant.signUp.text,
      style: ButtonComponentStyle.secondary,
      actionButton: () => context.read<LoginBloc>().add(LoginEventNavigateTo('/register')),
    )
  );


  Widget _renderForgotPassword(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 5),
    width: double.infinity,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: TextConstant.forgotMyPassword.text,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppUtil.showDialogUtil(
                      context: context, 
                      title: TextConstant.toBeContinued.text, 
                      message: TextConstant.pageInConstruction.text);
              },
            style: const TextStyle(
                color: Colors.black, decoration: TextDecoration.underline))
      ]),
    ));



  void _signIn(BuildContext context) {

    getIt<ContextManager>().context = context;

    var signInPatientDomainModel = SignInPatientDomainModel(
      email: _textEmailController.text.trim(),
      password: _textPasswordController.text.trim(),
      firebaseToken: context.read<LoginBloc>().firebaseToken,
    );


    context.read<LoginBloc>().add(LoginEventLoginPatient(signInPatientDomainModel, _formKey.currentState?.validate() ?? false));
  }
  




}