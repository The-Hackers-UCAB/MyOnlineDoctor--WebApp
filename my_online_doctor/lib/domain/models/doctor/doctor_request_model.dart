//Package imports
import 'dart:convert';


DoctorRequestModel doctorRequestModelFromJson(Map<String, dynamic> data) => DoctorRequestModel.fromJson(data);



class DoctorRequestModel {
  String id;
  String firstName;
  String firstSurname;
  String gender;
  String status;
  String rating;
  List<Specialty> specialties;


  DoctorRequestModel({
    required this.id,
    required this.firstName,
    required this.firstSurname,
    required this.gender,
    required this.status,
    required this.rating,
    required this.specialties,
  });


  factory DoctorRequestModel.fromJson(Map<String, dynamic> json) => DoctorRequestModel(
    id: json['id'],
    firstName: json['firstName'],
    firstSurname: json['firstSurname'],
    gender: json['gender'],
    status: json['status'],
    rating: json['rating'],
    specialties: List<Specialty>.from(json['specialties'].map((x) => Specialty.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'firstSurname': firstSurname,
    'gender': gender,
    'status': status,
    'rating' : rating,
    'specialties' : List<dynamic>.from(specialties.map((x) => x.toJson())),

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