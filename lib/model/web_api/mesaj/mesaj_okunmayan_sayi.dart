// To parse this JSON data, do
//
//     final modelMesajOkunmayanSayi = modelMesajOkunmayanSayiFromJson(jsonString);

import 'dart:convert';

ModelMesajOkunmayanSayi? modelMesajOkunmayanSayiFromJson(String str) =>
    ModelMesajOkunmayanSayi.fromJson(json.decode(str));

String modelMesajOkunmayanSayiToJson(ModelMesajOkunmayanSayi? data) =>
    json.encode(data!.toJson());

class ModelMesajOkunmayanSayi {
  ModelMesajOkunmayanSayi({
    required this.success,
    required this.data,
  });

  int? success;
  List<MesajOkunmayanSayiData?>? data;

  factory ModelMesajOkunmayanSayi.fromJson(Map<String, dynamic> json) =>
      ModelMesajOkunmayanSayi(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<MesajOkunmayanSayiData?>.from(
                json["data"]!.map((x) => MesajOkunmayanSayiData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class MesajOkunmayanSayiData {
  MesajOkunmayanSayiData({
    required this.id,
    required this.okunmayan,
  });

  dynamic id;
  int okunmayan;

  factory MesajOkunmayanSayiData.fromJson(Map<String, dynamic> json) => MesajOkunmayanSayiData(
        id: json["_id"],
        okunmayan: json["okunmayan"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okunmayan": okunmayan,
      };
}
