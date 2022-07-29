import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/bloc/patient_profile/profile_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

import '../../core/constants/text_constants.dart';
import '../components/dialog_component.dart';
import '../components/loading_component.dart';

class PatientProfilePage extends StatelessWidget{

  static const routeName = '/patient_profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
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
      AppBar(backgroundColor: colorPrimary, title: Text(TextConstant.profileTitle.text), centerTitle: true,);

  //Widget Body
  Widget _body(BuildContext context, ProfileState state) {
    if (state is ProfileStateInitial) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      var dialogResponse = await _showDialog(context);
      context.read<ProfileBloc>().add(ProfileEventNavigateToWith('/bottom_menu'));

    });

     
    }

    return const LoadingComponent();
  }



  dynamic _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) => DialogComponent(
        textTitle: TextConstant.toBeContinued.text,
        textQuestion: TextConstant.pageInConstruction.text,
        cancelButton: false,
      ),
    );
  }
}