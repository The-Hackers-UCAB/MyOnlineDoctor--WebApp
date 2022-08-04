//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/patient_detail/patient_detail_bloc.dart';
import 'package:my_online_doctor/domain/enumerations/phone_prefix_enum.dart';

import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class PatientDetailPage extends StatelessWidget {
  static const routeName = '/patient_detail';

  final PatientRequestModel patient;

  PatientDetailPage({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PatientDetailBloc(),
      child: BlocBuilder<PatientDetailBloc, PatientDetailState>(
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

  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
      backgroundColor: colorPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ));

  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, PatientDetailState state) {
    if (state is PatientDetailStateInitial) {
      //Esto que voy a hacer es horrible, lo sé, pero no se como hacerlo mejor xd

      context.read<PatientDetailBloc>().add(PatientDetailEventFetchBasicData(
            PatientRequestModel(
              id: patient.id,
              firstName: patient.firstName,
              firstSurname: patient.firstSurname,
              gender: patient.gender,
              status: patient.status,
              allergies: patient.allergies,
              background: patient.background,
              birthdate: patient.birthdate,
              height: patient.height,
              weight: patient.weight,
              phoneNumber: patient.phoneNumber,
              surgeries: patient.surgeries,
              middleName: patient.middleName,
              secondSurname: patient.secondSurname,
            ),
          ));
    }

    return Stack(
      children: [
        if (state is! PatientDetailStateInitial)
          _PatientDetailStreamBuilder(context),
        if (state is PatientDetailStateInitial ||
            state is PatientDetailStateLoading)
          const LoadingComponent(),
      ],
    );
  }

  //StreamBuilder for the Login Page
  Widget _PatientDetailStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<PatientRequestModel>(
          stream: builderContext.read<PatientDetailBloc>().streamPatientDetail,
          builder: (BuildContext context,
              AsyncSnapshot<PatientRequestModel> snapshot) {
            if (snapshot.hasData) {
              return _renderPatientBody(context);
            }

            return const LoadingComponent();
          });

  Widget _renderPatientBody(BuildContext context) => Scaffold(
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          Center(
            child: Image.asset(
              'assets/images/doctor_logo.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          heightSeparator(context, 0.01),
          _buildPatientTopInformation(context),
          heightSeparator(context, 0.05),
          _buildPatientStatus(context),
          heightSeparator(context, 0.01),
          _buildPatientBirthDate(context),
          heightSeparator(context, 0.01),
          _buildPatientPhoneNumber(context),
          heightSeparator(context, 0.01),
          _buildPatientAllergies(context),
          heightSeparator(context, 0.01),
          _buildPatientBackground(context)
        ]),
      );

  Widget _buildPatientTopInformation(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          heightSeparator(context, 0.01),
          patient.gender == 'M'
              ? Text(
                  'Paciente: Sr. ${patient.firstName} ${patient.firstSurname}',
                  style: const TextStyle(fontSize: 20),
                )
              : Text(
                  'Paciente: Sra. ${patient.firstName} ${patient.firstSurname}',
                  style: const TextStyle(fontSize: 20))
        ],
      );

  Widget _buildPatientStatus(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Status actual: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              patient.status,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      );

  Widget _buildPatientBirthDate(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Fecha de nacimiento: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(patient.birthdate),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildPatientPhoneNumber(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Teléfono: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              patient.phoneNumber,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildPatientAllergies(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Alergias: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              patient.allergies,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildPatientBackground(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Background: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              patient.background,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _PatientRenderButton(
          BuildContext context,
          ButtonComponentStyle buttonComponentStyle,
          String title,
          PatientDetailEvent event) =>
      Container(
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 25),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.065,
          child: ButtonComponent(
            style: buttonComponentStyle,
            title: title,
            actionButton: () => context.read<PatientDetailBloc>().add(event),
          ));

  // Widget _appointmentRenderButton(
  //   BuildContext context,
  //   ButtonComponentStyle buttonComponentStyle,
  //   String title,
  //   PatientDetailEvent event,
  // ) =>
  //     Container(
  //         margin:
  //             const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 25),
  //         width: double.infinity / 2,
  //         height: MediaQuery.of(context).size.height * 0.065,
  //         child: ButtonComponent(
  //           style: buttonComponentStyle,
  //           title: title,
  //           actionButton: () => context
  //               .read<PatientDetailBloc>()
  //               .add(PatientDetailEventNavigateToWith('/patient_detail', item)),
  //         ));
}
