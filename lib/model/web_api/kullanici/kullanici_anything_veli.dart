// To parse this JSON data, do
//
//     final modelKullaniciAnythingVeli = modelKullaniciAnythingVeliFromJson(jsonString);

import 'dart:convert';

ModelKullaniciAnythingVeli modelKullaniciAnythingVeliFromJson(String str) =>
    ModelKullaniciAnythingVeli.fromJson(json.decode(str));

String modelKullaniciAnythingVeliToJson(ModelKullaniciAnythingVeli data) =>
    json.encode(data.toJson());

class ModelKullaniciAnythingVeli {
  ModelKullaniciAnythingVeli({
    required this.success,
    required this.data,
  });

  int success;
  List<AnythingVeliData> data;

  factory ModelKullaniciAnythingVeli.fromJson(Map<String, dynamic> json) =>
      ModelKullaniciAnythingVeli(
        success: json["success"],
        data:
            List<AnythingVeliData>.from(json["data"].map((x) => AnythingVeliData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AnythingVeliData {
  AnythingVeliData({
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
  Yetki yetki;
  bool bildirim;
  DateTime sonGirisTarihi;

  factory AnythingVeliData.fromJson(Map<String, dynamic> json) => AnythingVeliData(
        id: json["_id"],
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
        ebeveynMi: json["ebeveynMi"],
        gorunme: json["gorunme"],
        cv: json["cv"],
        yetki: Yetki.fromJson(json["yetki"]),
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

class Yetki {
  Yetki({
    required this.veli,
    required this.ogretmen,
    required this.admin,
    required this.brans,
  });

  bool veli;
  bool ogretmen;
  bool admin;
  bool brans;

  factory Yetki.fromJson(Map<String, dynamic> json) => Yetki(
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
