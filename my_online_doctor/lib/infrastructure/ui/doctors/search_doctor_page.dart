//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SearchDoctorPage extends StatelessWidget{

  static const routeName = '/search_doctor';

  //Controllers
  final TextEditingController _searchDoctorController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => DoctorBloc(),
      child: BlocBuilder<DoctorBloc, DoctorState>(
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
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( 
    backgroundColor: colorPrimary,
    title: Text(TextConstant.doctors.text),
    centerTitle: true,
  );


    //Widget Body
  Widget _body(BuildContext context, DoctorState state) {
    
    if(state is DoctorStateInitial) {
      context.read<DoctorBloc>().add(DoctorEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! DoctorStateInitial) _viewDoctorsRenderView(context),
        if(state is DoctorStateInitial || state is DoctorStateLoading) const LoadingComponent(),
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
    onSubmitted: _searchDoctor, 
    hintText: 'Buscar doctores por especialidad'
  );



  /// This function [_searchDoctor] is used to search the doctors.
  /// It is called when the user presses the enter key.
  /// It is also called when the user clicks on the search button.
  void _searchDoctor(String text) {
    
    var context = getIt<ContextManager>().context;
    context.read<DoctorBloc>().add(DoctorEventSearchDoctor(text));
  }



  //StreamBuilder for the Login Page
  Widget _doctorStreamBuilder(BuildContext builderContext) => StreamBuilder<List<DoctorRequestModel>>(
    stream: builderContext.read<DoctorBloc>().streamDoctor,
    builder: (BuildContext context, AsyncSnapshot<List<DoctorRequestModel>> snapshot) {

      if(snapshot.hasData) {
        if(snapshot.data!.isNotEmpty) {

          // return _renderMainBody(context, snapshot.data!);

        } else {
          return Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            child: const ShowErrorComponent(errorImagePath:'assets/images/no_doctor_found.png')
          );
        }
      } 

      return const LoadingComponent();
    }
  );






}