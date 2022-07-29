//Package imports
import 'dart:convert';

ScheduleAppointmentModel ScheduleAppointmentModelFromJson(String str) =>
    ScheduleAppointmentModel.fromJson(json.decode(str));

String ScheduleAppointmentModelToJson(ScheduleAppointmentModel data) =>
    json.encode(data.toJson());

class ScheduleAppointmentModel {
  String id;
  DateTime? date;
  int? duration;

  ScheduleAppointmentModel(
      {required this.id, required this.date, required this.duration});

  factory ScheduleAppointmentModel.fromJson(Map<String, dynamic> json) =>
      ScheduleAppointmentModel(
        id: json["id"],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "date": date!.toIso8601String(), "duration": duration!};
}
