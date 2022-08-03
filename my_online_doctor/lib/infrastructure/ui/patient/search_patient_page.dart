//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_online_doctor/application/bloc/doctor/doctor_bloc.dart';
import 'package:my_online_doctor/application/bloc/patient_list/patient_list_bloc.dart';
import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/search_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/show_error_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class SearchPatientPage extends StatelessWidget {
  static const routeName = '/search_patient';

  //Controllers
  final TextEditingController _searchPatientController =
      TextEditingController(text: '');

  SearchPatientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => PatientListBloc()..add(FetchBasicData()),
      child: BlocBuilder<PatientListBloc, PatientListState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: _body(context, state)),
            ),
            floatingAcctionButton: _renderFloatingActionButton(context),
          );
        },
      ),
    );
  }

  //Widget for the doctors search filters
  Widget _renderFloatingActionButton(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.list_view,
      backgroundColor: colorPrimary,
      spacing: 12,
      children: [
        SpeedDialChild(
            child: const Icon(Icons.person, color: Colors.white),
            backgroundColor: colorSecondary,
            label: 'Buscar por nombre',
            onTap: () {
              context
                  .read<PatientListBloc>()
                  .add(ChangedSearchFilter('Buscar por nombre'));
            }),
        SpeedDialChild(
            child: const Icon(Icons.person_search, color: Colors.white),
            backgroundColor: colorSecondary,
            label: 'Filtrar por apellido',
            onTap: () {
              context
                  .read<PatientListBloc>()
                  .add(ChangedSearchFilter('Buscar por apellido'));
            }),
      ],
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
        backgroundColor: colorPrimary,
        title: Text(TextConstant.patients.text),
        centerTitle: true,
      );

  //Widget Body
  Widget _body(BuildContext context, PatientListState state) {
    if (state is PatientListInitial) {
      context.read<PatientListBloc>().add(FetchBasicData());
    }

    return Stack(
      children: [
        if (state is! PatientListInitial) _viewDoctorsRenderView(context),
        if (state is PatientListInitial || state is PatientListLoading)
          const LoadingComponent(),
      ],
    );
  }

  Widget _viewDoctorsRenderView(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDoctorSearchBar(context),
          Expanded(
            child: _doctorStreamBuilder(context),
          ),
        ],
      );

  /// This function [_buildDoctorSearchBar] is used to build the search bar of the doctors.
  Widget _buildDoctorSearchBar(BuildContext context) => SearchFieldComponent(
      text: _searchPatientController.text,
      onSubmitted: (String value) {
        context
            .read<PatientListBloc>()
            .add(SearchPatient(value.trim().toUpperCase()));
      },
      hintText: context.read<PatientListBloc>().searchFilter);

  //StreamBuilder for the Login Page
  Widget _doctorStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<List<PatientRequestModel>>(
          stream: builderContext.read<PatientListBloc>().streamPatient,
          builder: (BuildContext context,
              AsyncSnapshot<List<PatientRequestModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return _renderMainBody(context, snapshot.data!);
              } else {
                return Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    child: const ShowErrorComponent(
                        errorImagePath: 'assets/images/no_doctor_found.png'));
              }
            }

            return const LoadingComponent();
          });

  Widget _renderMainBody(
          BuildContext context, List<PatientRequestModel> data) =>
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (listContext, index) =>
              _renderDoctorItem(context, data[index]),
        ),
      );

  Widget _renderDoctorItem(BuildContext context, PatientRequestModel item) {
    //Log
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 20),
        width: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: ClipOval(
                      child: Image.asset('assets/images/doctor_logo.png',
                          width: 40, height: 40, fit: BoxFit.cover)),
                  title: item.gender == 'M'
                      ? Text(
                          'Sr. ${item.firstName} ${item.firstSurname}',
                          style: const TextStyle(fontSize: 18),
                        )
                      : Text(
                          'Sra. ${item.firstName} ${item.firstSurname}',
                          style: const TextStyle(fontSize: 18),
                        ),
                  // subtitle:Text(item.specialties[0].specialty),
                  subtitle: Text(item.phoneNumber),
                  trailing: null,
                  onTap: () {
                    context
                        .read<PatientListBloc>()
                        .add(NavigateTo('/view_appointments', item));
                  },
                ),
              ],
            )));
  }
}
