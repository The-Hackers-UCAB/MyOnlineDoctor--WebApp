import 'package:my_online_doctor/domain/models/patient/patient_request_model.dart';

class PatientExamples {
  static PatientRequestModel validPatient() => PatientRequestModel(
      id: "c6b52d5a-f972-41e4-883e-70c3fe23bcce",
      firstName: "Carlos",
      firstSurname: "Doffiny",
      gender: "M",
      status: "ACTIVO",
      allergies: "A la vida",
      background: "Falta de sueño por desarrollo",
      birthdate: DateTime.parse("1998-07-15"),
      height: "1.850",
      weight: "85.000",
      phoneNumber: "424123",
      surgeries: "3 cirugías",
      middleName: "Antonio",
      secondSurname: "Sanchez Vegas");
}
