// ignore_for_file: use_build_context_synchronously
//Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:my_online_doctor/application/bloc/logout/logout_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';

class LogoutPage extends StatelessWidget {
  static const routeName = '/logout';

  LogoutPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => LogoutBloc(),
      child: BlocBuilder<LogoutBloc, LogoutState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) =>
      AppBar(backgroundColor: colorPrimary, title: Text(TextConstant.logoutTitle.text), centerTitle: true,);

  //Widget Body
  Widget _body(BuildContext context, LogoutState state) {
    if (state is LogoutStateInitial) {

    WidgetsBinding.instance.addPostFrameCallback((_) async{

      var dialogResponse = await _showDialog(context);

      if(dialogResponse != null && dialogResponse){
        context.read<LogoutBloc>().add(LogoutEventLogoutPatient());
      } else {
        context.read<LogoutBloc>().add(LogoutEventNavigateToWith('/bottom_menu'));
      }

    });

     
    }

    return const LoadingComponent();
  }


  dynamic _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) => DialogComponent(
        textTitle: TextConstant.logoutTitle.text,
        textQuestion: TextConstant.areYouSure.text,
        cancelButton: true,
      ),
    );
  }

 
}
