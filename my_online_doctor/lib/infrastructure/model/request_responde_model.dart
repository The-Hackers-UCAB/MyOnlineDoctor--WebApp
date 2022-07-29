import 'dart:convert';

RequestResponseModel requestResponseModelFromJson(String str) => RequestResponseModel.fromJson(json.decode(str));

String requestResponseModelToJson(RequestResponseModel data) => json.encode(data.toJson());

class RequestResponseModel {
  RequestResponseModel({
    this.responseReturn,
    this.message,
    this.status,
    this.data,
  });

  bool? responseReturn;
  String? message;
  int? status;
  dynamic data;

  RequestResponseModel copyWith({
    bool? errorResponseModelReturn,
    String? message,
    int? status,
    dynamic data,
  }) =>
      RequestResponseModel(
        responseReturn: errorResponseModelReturn ?? responseReturn,
        message: message ?? this.message,
        status: status ?? this.status,
          data: data?? this.data
      );

  factory RequestResponseModel.fromJson(Map<String, dynamic> json) => RequestResponseModel(
    responseReturn: json['return'],
    message: json['message'],
    status: json['status'],
    data: json['data'],
  );

  Map<String, dynamic> toJson() => {
    'return': responseReturn,
    'message': message,
    'status': status,
    'data': data == null ? null : data!.toJson(),
  };
}
