//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/appointment_detail/appointment_detail_bloc.dart';
import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/appointment_detail_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/domain/services/appointment_status_color_service.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

import '../../../domain/models/appointment/schedule_appointment_model.dart';

class AppointmentDetailPage extends StatelessWidget {
  static const routeName = '/appointment_detail';

  final RequestAppointmentModel appointment;

  AppointmentDetailPage({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AppointmentDetailBloc(),
      child: BlocBuilder<AppointmentDetailBloc, AppointmentDetailState>(
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
        onPressed: () => context
            .read<AppointmentDetailBloc>()
            .add(AppointmentDetailEventNavigateToWith('/bottom_menu')),
      ));

  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, AppointmentDetailState state) {
    if (state is AppointmentDetailStateInitial) {
      //Esto que voy a hacer es horrible, lo sé, pero no se como hacerlo mejor xd

      context
          .read<AppointmentDetailBloc>()
          .add(AppointmentDetailEventFetchBasicData(
            AppointmentDetailModel(
              id: appointment.id,
              date: appointment.date,
              description: appointment.description,
              duration: appointment.duration,
              status: appointment.status,
              type: appointment.type,
              patient: appointment.patient,
              doctor: appointment.doctor,
              specialty: appointment.specialty,
            ),
          ));
    }

    return Stack(
      children: [
        if (state is! AppointmentDetailStateInitial)
          _appointmentDetailStreamBuilder(context),
        if (state is AppointmentDetailStateInitial ||
            state is AppointmentDetailStateLoading)
          const LoadingComponent(),
      ],
    );
  }

  //StreamBuilder for the Login Page
  Widget _appointmentDetailStreamBuilder(BuildContext builderContext) =>
      StreamBuilder<AppointmentDetailModel>(
          stream: builderContext
              .read<AppointmentDetailBloc>()
              .streamAppointmentDetail,
          builder: (BuildContext context,
              AsyncSnapshot<AppointmentDetailModel> snapshot) {
            if (snapshot.hasData) {
              return _renderAppointmentBody(context);
            }

            return const LoadingComponent();
          });

  Widget _renderAppointmentBody(BuildContext context) => Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Center(
              child: Image.asset(
                'assets/images/doctor_logo.png',
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            heightSeparator(context, 0.01),
            _buildAppointmentTopInformation(context),
            heightSeparator(context, 0.05),
            _buildAppointmentStatus(context),
            heightSeparator(context, 0.01),
            _buildAppointmentDateTime(context),
            heightSeparator(context, 0.01),
            _buildAppointmentDuration(context),
            heightSeparator(context, 0.01),
            _buildAppointmentType(context),
            heightSeparator(context, 0.01),
            _buildAppointmentDescription(context),
            if (appointment.status == 'ACEPTADA')
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: generalMarginView,
                    child: _appointmentRenderButton(
                        context,
                        ButtonComponentStyle.canceled,
                        TextConstant.cancelAppointment.text,
                        AppointmentDetailEventCancelled(
                            CancelAppointmentModel(id: appointment.id),
                            context)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: generalMarginView,
                    child: _appointmentRenderButton(
                        context,
                        ButtonComponentStyle.accepted,
                        TextConstant.callPatient.text,
                        AppointmentDetailEventCalled(
                            AcceptAppointmentModel(id: appointment.id),
                            context)),
                  ),
                ),
              ]),
            if (appointment.status == 'SOLICITADA')
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: generalMarginView,
                    child: _appointmentRenderButton(
                        context,
                        ButtonComponentStyle.canceled,
                        TextConstant.rejectAppointment.text,
                        AppointmentDetailEventRejected(
                            RejectAppointmentModel(id: appointment.id),
                            context)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    margin: generalMarginView,
                    child: _appointmentRenderButton(
                        context,
                        ButtonComponentStyle.accepted,
                        TextConstant.scheduleAppointment.text,
                        ScheduleAppointmentDetailEventAccepted(
                            ScheduleAppointmentModel(
                                id: appointment.id,
                                date: appointment.date ?? DateTime.now(),
                                duration: 1),
                            context)),
                  ),
                ),
              ]),
          ],
        ),
      );

  Widget _buildAppointmentTopInformation(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            appointment.specialty.specialty,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 30, color: colorPrimary),
          ),
          heightSeparator(context, 0.01),
          appointment.doctor.gender == 'M'
              ? Text(
                  'Paciente: Sr. ${appointment.patient.firstName} ${appointment.patient.firstSurname}',
                  style: const TextStyle(fontSize: 20),
                )
              : Text(
                  'Paciente: Sra. ${appointment.patient.firstName} ${appointment.patient.firstSurname}',
                  style: const TextStyle(fontSize: 20))
        ],
      );

  Widget _buildAppointmentStatus(BuildContext context) => Padding(
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
              appointment.status,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 16,
                  color:
                      AppointmentStatusColorService.getAppointmentStatusColor(
                          appointment.status)),
            ),
          ],
        ),
      );

  Widget _buildAppointmentDateTime(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Fecha y hora: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              appointment.date != null
                  ? DateFormat('dd/MM/yyyy hh:mm a').format(appointment.date!)
                  : 'Por Definir',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildAppointmentDuration(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Duración: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              appointment.duration != null
                  ? '${appointment.duration.toString()} horas'
                  : 'Por Definir',
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildAppointmentType(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Modalidad: ',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
            ),
            Text(
              appointment.type,
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
            ),
          ],
        ),
      );

  Widget _buildAppointmentDescription(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Motivo de solicitud: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
              heightSeparator(context, 0.01),
              Text(
                appointment.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
                maxLines: null,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      );

  Widget _appointmentRenderButton(
          BuildContext context,
          ButtonComponentStyle buttonComponentStyle,
          String title,
          AppointmentDetailEvent event) =>
      Container(
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 25),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.065,
          child: ButtonComponent(
            style: buttonComponentStyle,
            title: title,
            actionButton: () =>
                context.read<AppointmentDetailBloc>().add(event),
          ));
}
