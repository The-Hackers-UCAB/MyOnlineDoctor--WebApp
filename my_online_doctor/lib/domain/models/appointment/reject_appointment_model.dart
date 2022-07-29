//Package imports
import 'dart:convert';

RejectAppointmentModel rejectAppointmentModelFromJson(String str) => RejectAppointmentModel.fromJson(json.decode(str));

String rejectAppointmentModelToJson(RejectAppointmentModel data) => json.encode(data.toJson());


class RejectAppointmentModel{

  String id;

  RejectAppointmentModel({
    required this.id,
  });

  factory RejectAppointmentModel.fromJson(Map<String, dynamic> json) => RejectAppointmentModel(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
  
}