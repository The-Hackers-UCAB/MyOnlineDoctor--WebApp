import 'dart:convert';

dynamic requestValueResponseModelFromJson(String str) => RequestValueResponseModel.fromJson(json.decode(str)).value;

String requestValueResponseModelToJson(RequestValueResponseModel data) => json.encode(data.toJson());

class RequestValueResponseModel {
  RequestValueResponseModel({
    this.value
  });

  dynamic value;

  RequestValueResponseModel copyWith({
    dynamic value,
  }) =>
      RequestValueResponseModel(
        value: value,
      );

  factory RequestValueResponseModel.fromJson(Map<String, dynamic> json) => RequestValueResponseModel(
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {
    'value' : value,
  };
}
