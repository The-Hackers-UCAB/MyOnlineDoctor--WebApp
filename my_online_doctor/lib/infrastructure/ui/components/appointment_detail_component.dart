import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class AppointmentDetailComponent extends StatelessWidget {
  static const routeName = '/appointment_detail';
  final RequestAppointmentModel appointment;

  const AppointmentDetailComponent({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      backgroundColor: colorWhite,
      child: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Image.asset('assets/images/doctor_logo.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              top:0, 
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close,color: colorPrimary,),
                iconSize: 30,
                onPressed: ()=>Navigator.of(context).pop()
              )
            ),
          ]
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              content(context)
            ],
          ),
        )
      ],
    );
  }

  Widget content(BuildContext context){
    return Column(children: [
      Text(
        appointment.specialty.specialty,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20, color: colorPrimary),
      ),
      const SizedBox(height: 8,),
      Row(children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time_outlined,color: colorPrimary,),
              const SizedBox(width: 4,),
              Text(appointment.date != null ? DateFormat('dd/MM/yyyy hh:mm a').format(appointment.date!) : 'Por Definir',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.recommend_outlined,color: colorPrimary,),
              const SizedBox(width: 4,),
              Text(appointment.type[0].toUpperCase() + appointment.type.substring(1),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ],),
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          appointment.description,
          textAlign:TextAlign.justify,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ),

    ],);
  }
}
