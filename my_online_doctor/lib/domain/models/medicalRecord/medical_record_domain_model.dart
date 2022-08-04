import 'dart:convert';

MedicalRecordDomainModel medicalRecordDomainModelFromJson(String str) => MedicalRecordDomainModel.fromJson(json.decode(str));

String medicalRecordDomainModelToJson(MedicalRecordDomainModel data) => json.encode(data.toJson());

class MedicalRecordDomainModel {

  DtoRecord dto;

  MedicalRecordDomainModel({
    required this.dto,
  });

  factory MedicalRecordDomainModel.fromJson(Map<String, dynamic> json) => MedicalRecordDomainModel(
    dto: DtoRecord.fromJson(json['dto']),
  );

  Map<String, dynamic> toJson() => {
    "dto": dto.toJson(),
  };

}

class DtoRecord{

  String description;
  String diagnostic;
  String exams;
  String recipe;
  String planning;
  String date;

  DtoRecord({
    required this.description,
    required this.diagnostic,
    required this.exams,
    required this.recipe,
    required this.planning,
    required this.date,
  });

  factory DtoRecord.fromJson(Map<String, dynamic> json) => DtoRecord(
    description: json['description'],
    diagnostic: json['diagnostic'],
    exams: json['exams'],
    recipe: json['recipe'],
    planning: json['planning'],
    date: json['date'],
  );

  Map<String, dynamic> toJson() => {
    'description': description,
    'diagnostic' : diagnostic,
    'exams': exams,
    'recipe': recipe,
    'planning': planning,
    'date': date,  
  };

}