//Package imports
import 'dart:convert';

AcceptAppointmentModel acceptAppointmentModelFromJson(String str) => AcceptAppointmentModel.fromJson(json.decode(str));

String acceptAppointmentModelToJson(AcceptAppointmentModel data) => json.encode(data.toJson());


class AcceptAppointmentModel{

  String id;

  AcceptAppointmentModel({
    required this.id,
  });

  factory AcceptAppointmentModel.fromJson(Map<String, dynamic> json) => AcceptAppointmentModel(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
  
}