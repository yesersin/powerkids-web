// To parse this JSON data, do
//
//     final modelUploadFile = modelUploadFileFromJson(jsonString);

import 'dart:convert';

ModelUploadFile modelUploadFileFromJson(String str) =>
    ModelUploadFile.fromJson(json.decode(str));

String modelUploadFileToJson(ModelUploadFile data) => json.encode(data.toJson());

class ModelUploadFile {
  ModelUploadFile({
    required this.success,
    required this.data,
  });

  int success;
  String data;

  factory ModelUploadFile.fromJson(Map<String, dynamic> json) => ModelUploadFile(
        success: json["success"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
      };
}
