//Package imports
import 'dart:convert';

CancelAppointmentModel cancelAppointmentModelFromJson(String str) => CancelAppointmentModel.fromJson(json.decode(str));

String cancelAppointmentModelToJson(CancelAppointmentModel data) => json.encode(data.toJson());


class CancelAppointmentModel{

  String id;

  CancelAppointmentModel({
    required this.id,
  });

  factory CancelAppointmentModel.fromJson(Map<String, dynamic> json) => CancelAppointmentModel(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
  
}