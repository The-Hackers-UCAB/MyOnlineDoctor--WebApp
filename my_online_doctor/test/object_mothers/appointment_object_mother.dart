import 'package:my_online_doctor/domain/models/appointment/appointment_detail_model.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';

class AppointmentExamples {
  static RequestAppointmentModel scheduledAppointment() {
    return RequestAppointmentModel(
        id: '1',
        date: DateTime.now(),
        description: 'Descripcion',
        duration: 1,
        status: "AGENDADA",
        type: "VIRTUAL",
        patient: PatientRequestModel(
            id: 'ID',
            firstName: "Paciente",
            firstSurname: "Paciente",
            gender: "MALE",
            status: "ACTIVO",
            allergies: "none",
            background: "none",
            birthdate: DateTime.now(),
            height: "none",
            weight: "none",
            phoneNumber: "none",
            surgeries: "none",
            middleName: "none",
            secondSurname: "none"),
        doctor: Doctor(
            id: "1",
            firstName: "Doctor",
            firstSurname: "Doctor",
            gender: "MALE",
            status: "ACTIVO"),
        specialty: Specialty(id: 1, specialty: "CARDIOLOGY"));
  }

  static String getCompletedAppointment() => 'COMPLETADA';

  static String getAcceptedAppointment() => 'ACEPTADA';

  static String getInitiatedAppointment() => 'INICIADA';

  static String getScheduledAppointment() => 'AGENDADA';

  static String getRejectedAppointment() => 'RECHAZADA';

  static String getCancelledAppointment() => 'CANCELADA';

  static String getRequestedAppointment() => 'SOLICITADA';
}
