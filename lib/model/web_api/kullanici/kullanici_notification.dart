// To parse this JSON data, do
//
//     final modelKullaniciNotification = modelKullaniciNotificationFromJson(jsonString);

import 'dart:convert';

ModelKullaniciNotification modelKullaniciNotificationFromJson(String str) =>
    ModelKullaniciNotification.fromJson(json.decode(str));

String modelKullaniciNotificationToJson(ModelKullaniciNotification data) =>
    json.encode(data.toJson());

class ModelKullaniciNotification {
  ModelKullaniciNotification({
    required this.success,
    required this.data,
  });

  int success;
  List<KullaniciNotificationData> data;

  factory ModelKullaniciNotification.fromJson(Map<String, dynamic> json) =>
      ModelKullaniciNotification(
        success: json["success"],
        data: List<KullaniciNotificationData>.from(
            json["data"].map((x) => KullaniciNotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KullaniciNotificationData {
  KullaniciNotificationData({
    required this.id,
    required this.notificationId,
    required this.adSoyad,
    required this.ebeveynMi,
    required this.yetki,
  });

  String id;
  String notificationId;
  String adSoyad;
  bool ebeveynMi;
  Yetki yetki;

  factory KullaniciNotificationData.fromJson(Map<String, dynamic> json) =>
      KullaniciNotificationData(
        id: json["_id"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        ebeveynMi: json["ebeveynMi"],
        yetki: Yetki.fromJson(json["yetki"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "ebeveynMi": ebeveynMi,
        "yetki": yetki.toJson(),
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
