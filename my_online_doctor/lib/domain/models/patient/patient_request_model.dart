// To parse this JSON data, do
//
//     final patientDomain = patientDomainFromJson(jsonString);

import 'dart:convert';

PatientRequestModel patientRequestModelFromJson(Map<String, dynamic> data) =>
    PatientRequestModel.fromJson(data);

String patientRequestModelToJson(PatientRequestModel data) =>
    json.encode(data.toJson());

class PatientRequestModel {
  PatientRequestModel({
    required this.id,
    required this.firstName,
    required this.firstSurname,
    required this.gender,
    required this.status,
    required this.allergies,
    required this.background,
    required this.birthdate,
    required this.height,
    required this.weight,
    required this.phoneNumber,
    required this.surgeries,
    required this.middleName,
    required this.secondSurname,
  });

  String id;
  String firstName;
  String firstSurname;
  String gender;
  String status;
  String allergies;
  String background;
  DateTime birthdate;
  String height;
  String weight;
  String phoneNumber;
  String surgeries;
  String middleName;
  String secondSurname;

  factory PatientRequestModel.fromJson(Map<String, dynamic> json) =>
      PatientRequestModel(
        id: json["id"],
        firstName: json["firstName"],
        firstSurname: json["firstSurname"],
        gender: json["gender"],
        status: json["status"],
        allergies: json["allergies"],
        background: json["background"],
        birthdate: DateTime.parse(json["birthdate"]),
        height: json["height"],
        weight: json["weight"],
        phoneNumber: json["phoneNumber"],
        surgeries: json["surgeries"],
        middleName: json["middleName"],
        secondSurname: json["secondSurname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "firstSurname": firstSurname,
        "gender": gender,
        "status": status,
        "allergies": allergies,
        "background": background,
        "birthdate": birthdate.toIso8601String(),
        "height": height,
        "weight": weight,
        "phoneNumber": phoneNumber,
        "surgeries": surgeries,
        "middleName": middleName,
        "secondSurname": secondSurname,
      };
}
