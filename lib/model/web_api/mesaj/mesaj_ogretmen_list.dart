// To parse this JSON data, do
//
//     final modelMesajOgretmenList = modelMesajOgretmenListFromJson(jsonString);

import 'dart:convert';

ModelMesajOgretmenList modelMesajOgretmenListFromJson(String str) =>
    ModelMesajOgretmenList.fromJson(json.decode(str));

String modelMesajOgretmenListToJson(ModelMesajOgretmenList data) => json.encode(data.toJson());

class ModelMesajOgretmenList {
  ModelMesajOgretmenList({
    required this.success,
    required this.data,
  });

  int success;
  List<MesajOgretmenBilgi> data;

  factory ModelMesajOgretmenList.fromJson(Map<String, dynamic> json) => ModelMesajOgretmenList(
        success: json["success"],
        data: List<MesajOgretmenBilgi>.from(
            json["data"].map((x) => MesajOgretmenBilgi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MesajOgretmenBilgi {
  MesajOgretmenBilgi({
    required this.id,
    required this.notificationId,
    required this.adSoyad,
    required this.fotografUrl,
  });

  String id;
  String notificationId;
  String adSoyad;
  String fotografUrl;

  factory MesajOgretmenBilgi.fromJson(Map<String, dynamic> json) => MesajOgretmenBilgi(
        id: json["_id"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
      };
}
