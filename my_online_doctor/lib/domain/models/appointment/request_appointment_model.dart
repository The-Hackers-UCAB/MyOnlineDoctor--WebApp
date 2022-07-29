//Package imports
import 'dart:convert';

// List<RequestAppointmentModel> requestAppointmentModelFromJson(String str) => List<RequestAppointmentModel>.from(json.decode(str).map((x) => RequestAppointmentModel.fromJson(x)));

RequestAppointmentModel requestAppointmentModelFromJson(Map<String, dynamic> data) => RequestAppointmentModel.fromJson(data);

// String requestAppointmentModelToJson(List<RequestAppointmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


///RequestAppointmentModel: Model for get the list of Appointments

 
// class RequestAppointmentValue {

//   List<RequestAppointmentModel> value;

//   RequestAppointmentValue({
//     required this.value,
//   });

//   factory RequestAppointmentValue.fromJson(Map<String, dynamic> json) => RequestAppointmentValue(
//     value: List<RequestAppointmentModel>.from(json['value'].map((x) => RequestAppointmentModel.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "value": value,
//   };



// }

class RequestAppointmentModel {
  String id;
  DateTime? date;
  String description;
  int? duration;
  String status;
  String type;
  Patient patient;
  Doctor doctor;
  Specialty specialty;


  RequestAppointmentModel({
    required this.id,
    required this.date,
    required this.description,
    required this.duration,
    required this.status,
    required this.type,
    required this.patient,
    required this.doctor,
    required this.specialty,

  });


  factory RequestAppointmentModel.fromJson(Map<String, dynamic> json) => RequestAppointmentModel(
    id: json['id'],
    date: json['date'] == null ? null : DateTime.parse(json['date']),
    description: json['description'],
    duration: json['duration'],
    status: json['status'],
    type: json['type'],
    patient: Patient.fromJson(json['patient']),
    doctor: Doctor.fromJson(json['doctor']),
    specialty: Specialty.fromJson(json['specialty']),
  );


  Map<String, dynamic> toJson() => {
    'id' : id,
    'date' : date!.toIso8601String(),
    'description' : description,
    'duration' : duration,
    'status' : status,
    'type' : type,
    'patient' : patient.toJson(),
    'doctor' : doctor.toJson(),
    'specialty' : specialty.toJson(),

  };

}


class Patient {
  String id;
  String firstName;
  String firstSurname;
  String gender;
  String status;

  Patient({
    required this.id,
    required this.firstName,
    required this.firstSurname,
    required this.gender,
    required this.status,
  });


  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json['id'],
    firstName: json['firstName'],
    firstSurname: json['firstSurname'],
    gender: json['gender'],
    status: json['status'],
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'firstSurname': firstSurname,
    'gender': gender,
    'status': status,
  };

}


class Doctor {
  String id;
  String firstName;
  String firstSurname;
  String gender;
  String status;


  Doctor({
    required this.id,
    required this.firstName,
    required this.firstSurname,
    required this.gender,
    required this.status,
  });


  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json['id'],
    firstName: json['firstName'],
    firstSurname: json['firstSurname'],
    gender: json['gender'],
    status: json['status'],
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'firstSurname': firstSurname,
    'gender': gender,
    'status': status,
  };


}





class Specialty{
  int id;
  String specialty;

  Specialty({
    required this.id,
    required this.specialty,
  });


  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
    id: json['id'], 
    specialty: json['specialty']
  );


  Map<String, dynamic> toJson() => {
    'id' : id,
    'specialty' : specialty
  };


}