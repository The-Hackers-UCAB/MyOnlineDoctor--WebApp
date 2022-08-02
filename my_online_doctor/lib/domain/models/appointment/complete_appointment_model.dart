//Package imports
import 'dart:convert';

CompleteAppointmentModel completeAppointmentModelFromJson(String str) =>
    CompleteAppointmentModel.fromJson(json.decode(str));

String completeAppointmentModelToJson(CompleteAppointmentModel data) =>
    json.encode(data.toJson());

class CompleteAppointmentModel {
  String id;

  CompleteAppointmentModel({
    required this.id,
  });

  factory CompleteAppointmentModel.fromJson(Map<String, dynamic> json) =>
      CompleteAppointmentModel(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
