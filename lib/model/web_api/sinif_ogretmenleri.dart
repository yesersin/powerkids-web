// To parse this JSON data, do
//
//     final modelSinifOgretmenleri = modelSinifOgretmenleriFromJson(jsonString);

import 'dart:convert';

ModelSinifOgretmenleri modelSinifOgretmenleriFromJson(String str) =>
    ModelSinifOgretmenleri.fromJson(json.decode(str));

String modelSinifOgretmenleriToJson(ModelSinifOgretmenleri data) => json.encode(data.toJson());

class ModelSinifOgretmenleri {
  ModelSinifOgretmenleri({
    required this.success,
    required this.data,
  });

  int success;
  List<SinifOgretmenData> data;

  factory ModelSinifOgretmenleri.fromJson(Map<String, dynamic> json) => ModelSinifOgretmenleri(
        success: json["success"],
        data: List<SinifOgretmenData>.from(
            json["data"].map((x) => SinifOgretmenData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SinifOgretmenData {
  SinifOgretmenData({
    required this.id,
    required this.telefon,
    required this.notificationId,
    required this.adSoyad,
    required this.fotografUrl,
    required this.ebeveynMi,
    required this.gorunme,
    required this.cv,
    required this.yetki,
    required this.bildirim,
    required this.sonGirisTarihi,
  });

  String id;
  String telefon;
  String notificationId;
  String adSoyad;
  String fotografUrl;
  bool ebeveynMi;
  bool gorunme;
  String cv;
  SinifOgretmeniYetki yetki;
  bool bildirim;
  DateTime sonGirisTarihi;

  factory SinifOgretmenData.fromJson(Map<String, dynamic> json) => SinifOgretmenData(
        id: json["_id"],
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
        ebeveynMi: json["ebeveynMi"],
        gorunme: json["gorunme"],
        cv: json["cv"],
        yetki: SinifOgretmeniYetki.fromJson(json["yetki"]),
        bildirim: json["bildirim"],
        sonGirisTarihi: DateTime.parse(json["sonGirisTarihi"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "telefon": telefon,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
        "ebeveynMi": ebeveynMi,
        "gorunme": gorunme,
        "cv": cv,
        "yetki": yetki.toJson(),
        "bildirim": bildirim,
        "sonGirisTarihi": sonGirisTarihi.toIso8601String(),
      };
}

class SinifOgretmeniYetki {
  SinifOgretmeniYetki({
    required this.veli,
    required this.ogretmen,
    required this.admin,
    required this.brans,
  });

  bool veli;
  bool ogretmen;
  bool admin;
  bool brans;

  factory SinifOgretmeniYetki.fromJson(Map<String, dynamic> json) => SinifOgretmeniYetki(
        veli: json["veli"],
        ogretmen: json["ogretmen"],
        admin: json["admin"],
        brans: json["brans"],
      );

  Map<String, dynamic> toJson() => {
        "veli": veli,
        "ogretmen": ogretmen,
        "admin": admin,
        "brans": brans,
      };
}
