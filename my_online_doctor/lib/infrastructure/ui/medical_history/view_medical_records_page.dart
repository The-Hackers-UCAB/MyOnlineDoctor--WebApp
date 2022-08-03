//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/bloc/medical_history/medical_history_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/medical_record/medical_record_bloc.dart';
import 'package:my_online_doctor/domain/models/medical_history_record/view_medical_history_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/show_error_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class ViewMedicalRecordsPage extends StatelessWidget {
  static const routeName = '/view_medical_records';

  ViewMedicalRecordsPage({Key? key}) : super(key: key);

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
          );
        },
      ),
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
        backgroundColor: colorPrimary,
        title: Text(TextConstant.medicalRecordTitle.text),
        centerTitle: true,
      );

  //Widget Body
  Widget _body(BuildContext context, MedicalRecordState state) {
    if (state is MedicalRecordStateInitial) {
      context.read<MedicalRecordBloc>().add(MedicalRecordEventFetchBasicData());
    }

    return Stack(
      children: [
        if (state is! MedicalRecordStateInitial)
          _viewAppointmentsRenderView(context),
        if (state is MedicalRecordStateInitial ||
            state is MedicalRecordStateLoading)
          const LoadingComponent(),
      ],
    );
  }

  Widget _viewAppointmentsRenderView(context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: generalMarginView,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: _appointmentStreamBuilder(context),
              ),
            ),
          ),
        )

        // heightSeparator(context, 0.05),
        // _requestAppointmentRenderButton(context)
      ],
    );
  }

  //StreamBuilder for the Login Page
  Widget _appointmentStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<List<GetMedicalRecordModel>>(
          stream:
              builderContext.read<MedicalHistoryBloc>().streamMedicalHistory,
          builder: (BuildContext context,
              AsyncSnapshot<List<GetMedicalRecordModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return _renderMainBody(context, snapshot.data!);
              } else {
                return Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.1),
                    child: const ShowErrorComponent(
                        errorImagePath:
                            'assets/images/request_your_appointment.png'));
              }
            }

            return const LoadingComponent();
          });

  Widget _renderMainBody(
          BuildContext context, List<GetMedicalRecordModel> data) =>
      Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 20),
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (listContext, index) =>
              _renderAppointmentItem(context, data[index]),
        ),
      );

  Widget _renderAppointmentItem(
      BuildContext context, GetMedicalRecordModel item) {
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
                  title: Text("Registro medico Dr. " + item.doctor.firstName,
                      style: const TextStyle(fontSize: 15)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Descripcion del caso:",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(item.description,
                          style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                  onTap: () {
                    // AnaliticsService.logDetailedAppointment(item);
                    // context.read<MedicalRecordBloc>().add(
                    //     MedicalHistoryEventNavigateToWith(
                    //         '/medical_record_detail', item));
                  },
                ),
              ],
            )));
  }
}
