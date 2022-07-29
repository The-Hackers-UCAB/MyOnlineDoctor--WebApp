//Package import:
import 'package:flutter/material.dart';

//Project import:
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';


///AppointmentStatusColorService is a Domain Service class that provides the colors for the appointment status.
class AppointmentStatusColorService {

  static Color getAppointmentStatusColor(String status) {

      switch(status){
          case 'COMPLETADA':
            return colorPrimary;

          case 'ACEPTADA':
          case 'INICIADA':
            return colorGreen;

          case 'SOLICITADA':
          case 'AGENDADA':
            return colorYellow;

          case 'RECHAZADA':
          case 'CANCELADA':
          default:
            return colorError;
        }
    }

}