//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_online_doctor/application/bloc/doctor/doctor_bloc.dart';
import 'package:my_online_doctor/domain/models/doctor/doctor_request_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/search_field_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/show_error_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class SearchDoctorPage extends StatelessWidget {
  static const routeName = '/search_doctor';

  //Controllers
  final TextEditingController _searchDoctorController =
      TextEditingController(text: '');

  SearchDoctorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => DoctorBloc(),
      child: BlocBuilder<DoctorBloc, DoctorState>(
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
            label: 'Filtrar por apellido',
            onTap: () {
              context
                  .read<DoctorBloc>()
                  .add(DoctorEventChangedSearchFilter('Buscar por apellido'));
            }),
        SpeedDialChild(
            child: const Icon(Icons.person_search, color: Colors.white),
            backgroundColor: colorSecondary,
            label: 'Filtrar por nombre',
            onTap: () {
              context
                  .read<DoctorBloc>()
                  .add(DoctorEventChangedSearchFilter('Buscar por nombre'));
            }),
        SpeedDialChild(
            child: const Icon(Icons.badge, color: Colors.white),
            backgroundColor: colorSecondary,
            label: 'Filtrar por especialidad',
            onTap: () {
              context.read<DoctorBloc>().add(
                  DoctorEventChangedSearchFilter('Buscar por especialidad'));
            }),
      ],
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
        backgroundColor: colorPrimary,
        title: Text(TextConstant.doctors.text),
        centerTitle: true,
      );

  //Widget Body
  Widget _body(BuildContext context, DoctorState state) {
    if (state is DoctorStateInitial) {
      context.read<DoctorBloc>().add(DoctorEventFetchBasicData());
    }

    return Stack(
      children: [
        if (state is! DoctorStateInitial) _viewDoctorsRenderView(context),
        if (state is DoctorStateInitial || state is DoctorStateLoading)
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
      text: _searchDoctorController.text,
      onSubmitted: (String value) {
        context
            .read<DoctorBloc>()
            .add(DoctorEventSearchDoctor(value.trim().toUpperCase()));
      },
      hintText: context.read<DoctorBloc>().searchFilter);

  //StreamBuilder for the Login Page
  Widget _doctorStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<List<DoctorRequestModel>>(
          stream: builderContext.read<DoctorBloc>().streamDoctor,
          builder: (BuildContext context,
              AsyncSnapshot<List<DoctorRequestModel>> snapshot) {
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

  Widget _renderMainBody(BuildContext context, List<DoctorRequestModel> data) =>
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (listContext, index) =>
              _renderDoctorItem(context, data[index]),
        ),
      );

  Widget _renderDoctorItem(BuildContext context, DoctorRequestModel item) {
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
                          'Dr. ${item.firstName} ${item.firstSurname}',
                          style: const TextStyle(fontSize: 18),
                        )
                      : Text(
                          'Dra. ${item.firstName} ${item.firstSurname}',
                          style: const TextStyle(fontSize: 18),
                        ),
                  // subtitle:Text(item.specialties[0].specialty),
                  subtitle: _searchDoctorController.text != ''
                      ? Text(item.specialties
                          .singleWhere((specialty) =>
                              specialty.specialty ==
                              _searchDoctorController.text.trim().toUpperCase())
                          .specialty)
                      : (item.specialties.length > 1
                          ? Text(
                              '${item.specialties[0].specialty} y ${item.specialties[1].specialty}',
                              style: const TextStyle(fontSize: 12),
                            )
                          : Text(
                              item.specialties[0].specialty,
                              style: const TextStyle(fontSize: 12),
                            )),

                  trailing: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.yellow,
                          shadows: [Shadow(color: colorBlack, blurRadius: 0.5)],
                        ),
                        Text(
                          item.rating.toString().substring(0, 3),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context
                        .read<DoctorBloc>()
                        .add(DoctorEventNavigateTo('/doctor', item));
                  },
                ),
              ],
            )));
  }
}
