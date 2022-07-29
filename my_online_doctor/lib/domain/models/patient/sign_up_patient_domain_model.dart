//Package imports
import 'dart:convert';

SignUpPatientDomainModel signUpDomainModelFromJson(String str) => SignUpPatientDomainModel.fromJson(json.decode(str));

String signUpDomainModelToJson(SignUpPatientDomainModel data) => json.encode(data.toJson());


///SigUnUpPatientDomainModel: Model for register a Patient
class SignUpPatientDomainModel {

  Dto dto;
  CreateUserDto createUserDto;

  SignUpPatientDomainModel({
    required this.dto,
    required this.createUserDto,
  });

  factory SignUpPatientDomainModel.fromJson(Map<String, dynamic> json) => SignUpPatientDomainModel(
    dto: Dto.fromJson(json['dto']),
    createUserDto: CreateUserDto.fromJson(json['createUserDto']),
  );


  Map<String, dynamic> toJson() => {
    "dto": dto.toJson(),
    "createUserDto": createUserDto.toJson(),
  };

}


class Dto {

  String firstName;
  String middleName;
  String firstSurname;
  String secondSurname;
  String allergies;
  String background;
  String birthdate;
  String height;
  String phoneNumber;
  String status;
  String weight;
  String surgeries;
  String gender;


  Dto({
    required this.firstName,
    required this.middleName,
    required this.firstSurname,
    required this.secondSurname,
    required this.allergies,
    required this.background,
    required this.birthdate,
    required this.height,
    required this.phoneNumber,
    required this.status,
    required this.weight,
    required this.surgeries,
    required this.gender,
  });


  factory Dto.fromJson(Map<String, dynamic> json) => Dto(
    firstName: json['fisrtName'],
    middleName: json['middleName'],
    firstSurname: json['firstSurname'],
    secondSurname: json['secondSurname'],
    allergies: json['allergies'],
    background: json['background'],
    birthdate: json['birthdate'],
    height: json['height'],
    phoneNumber: json['phoneNumber'],
    status: json['status'],
    weight: json['weight'],
    surgeries: json['surgeries'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'middleName' : middleName,
    'firstSurname': firstSurname,
    'secondSurname': secondSurname,
    'allergies': allergies,
    'background': background,
    'birthdate': birthdate,
    'height': height,
    'phoneNumber': phoneNumber,
    'status': status,
    'weight' : weight,
    'surgeries': surgeries,
    'gender': gender,    
  };

}


class CreateUserDto {

  String email;
  String password;


  CreateUserDto({
    required this.email,
    required this.password,
  });


  factory CreateUserDto.fromJson(Map<String, dynamic> json) => CreateUserDto(
    email: json['email'],
    password: json['password'],
  );


  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };


}


