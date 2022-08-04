GetMedicalRecordModel GetMedicalRecordModelFromJson(
        Map<String, dynamic> data) =>
    GetMedicalRecordModel.fromJson(data);

class GetMedicalRecordModel {
  String id;
  DateTime? date;
  String description;
  String diagnostic;
  String exam;
  String recipe;
  String planning;
  Patient patient;
  Doctor doctor;
  Specialty specialty;

  GetMedicalRecordModel({
    required this.id,
    required this.date,
    required this.description,
    required this.patient,
    required this.doctor,
    required this.specialty,
    required this.diagnostic,
    required this.exam,
    required this.recipe,
    required this.planning,
  });

  factory GetMedicalRecordModel.fromJson(Map<String, dynamic> json) =>
      GetMedicalRecordModel(
        id: json['id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        description: json['description'] == null
            ? "Por Completar..."
            : json['description'],
        diagnostic: json['diagnostic'] == null
            ? "Por Completar..."
            : json['diagnostic'],
        exam: json['exam'] == null ? "Por Completar..." : json['exam'],
        recipe: json['recipe'] == null ? "Por Completar..." : json['recipe'],
        planning:
            json['planning'] == null ? "Por Completar..." : json['planning'],
        patient: Patient.fromJson(json['patient']),
        doctor: Doctor.fromJson(json['doctor']),
        specialty: Specialty.fromJson(json['specialty']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date!.toIso8601String(),
        'description': description,
        'patient': patient.toJson(),
        'doctor': doctor.toJson(),
        'specialty': specialty.toJson(),
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

class Specialty {
  int id;
  String specialty;

  Specialty({
    required this.id,
    required this.specialty,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) =>
      Specialty(id: json['id'], specialty: json['specialty']);

  Map<String, dynamic> toJson() => {'id': id, 'specialty': specialty};
}
