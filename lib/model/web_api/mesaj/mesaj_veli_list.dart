// To parse this JSON data, do
//
//     final modelMesajVeliList = modelMesajVeliListFromJson(jsonString);

import 'dart:convert';

ModelMesajVeliList modelMesajVeliListFromJson(String str) =>
    ModelMesajVeliList.fromJson(json.decode(str));

String modelMesajVeliListToJson(ModelMesajVeliList data) => json.encode(data.toJson());

class ModelMesajVeliList {
  ModelMesajVeliList({
    required this.success,
    required this.data,
  });

  int success;
  List<MesajVeliBilgi> data;

  factory ModelMesajVeliList.fromJson(Map<String, dynamic> json) => ModelMesajVeliList(
        success: json["success"],
        data: List<MesajVeliBilgi>.from(json["data"].map((x) => MesajVeliBilgi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MesajVeliBilgi {
  MesajVeliBilgi({
    required this.id,
    required this.okulId,
    required this.adSoyad,
    required this.sinifId,
    required this.veliAdSoyad,
    required this.veliId,
    required this.veliProfilResim,
    required this.notificationId,
  });

  String id;
  String okulId;
  String adSoyad;
  String sinifId;
  List<String> veliAdSoyad;
  List<String> veliId;
  List<String> veliProfilResim;
  List<String> notificationId;

  factory MesajVeliBilgi.fromJson(Map<String, dynamic> json) => MesajVeliBilgi(
        id: json["_id"],
        okulId: json["okulId"],
        adSoyad: json["adSoyad"],
        sinifId: json["sinifId"],
        veliAdSoyad: List<String>.from(json["veliAdSoyad"].map((x) => x)),
        veliId: List<String>.from(json["veliId"].map((x) => x)),
        veliProfilResim: List<String>.from(json["veliProfilResim"].map((x) => x)),
        notificationId: List<String>.from(json["notificationId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "adSoyad": adSoyad,
        "sinifId": sinifId,
        "veliAdSoyad": List<dynamic>.from(veliAdSoyad.map((x) => x)),
        "veliId": List<dynamic>.from(veliId.map((x) => x)),
        "veliProfilResim": List<dynamic>.from(veliProfilResim.map((x) => x)),
        "notificationId": List<dynamic>.from(notificationId.map((x) => x)),
      };
}
