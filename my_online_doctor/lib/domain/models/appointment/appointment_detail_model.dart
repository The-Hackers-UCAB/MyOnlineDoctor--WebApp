//Package imports
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';

// List<AppointmentDetailModel> AppointmentDetailModelFromJson(String str) => List<AppointmentDetailModel>.from(json.decode(str).map((x) => AppointmentDetailModel.fromJson(x)));

// AppointmentDetailModel appointmentDetailModelFromJson(String data) => AppointmentDetailModel.fromJson(json.decode(data));

// String AppointmentDetailModelToJson(List<AppointmentDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class AppointmentDetailModel extends RequestAppointmentModel{
  AppointmentDetailModel({
    required super.id, 
    required super.date, 
    required super.description, 
    required super.duration,
    required super.status, 
    required super.type,
    required super.patient,
    required super.doctor, 
    required super.specialty
  });
  

}

