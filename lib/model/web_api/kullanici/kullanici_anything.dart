// To parse this JSON data, do
//
//     final modelKullaniciAnyThing = modelKullaniciAnyThingFromJson(jsonString);

import 'dart:convert';

ModelKullaniciAnyThing modelKullaniciAnyThingFromJson(String str) =>
    ModelKullaniciAnyThing.fromJson(json.decode(str));

String modelKullaniciAnyThingToJson(ModelKullaniciAnyThing data) => json.encode(data.toJson());

class ModelKullaniciAnyThing {
  ModelKullaniciAnyThing({
    required this.success,
    required this.data,
  });

  int success;
  List<KullaniciAnything> data;

  factory ModelKullaniciAnyThing.fromJson(Map<String, dynamic> json) => ModelKullaniciAnyThing(
        success: json["success"],
        data: List<KullaniciAnything>.from(
            json["data"].map((x) => KullaniciAnything.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KullaniciAnything {
  KullaniciAnything({
    required this.id,
    required this.telefon,
    required this.notificationId,
    required this.adSoyad,
    required this.fotografUrl,
    required this.ozelNot,
    required this.ebeveynMi,
    required this.bildirim,
    required this.sonGirisTarihi,
  });

  String id;
  String telefon;
  String notificationId;
  String adSoyad;
  String fotografUrl;
  String ozelNot;
  bool ebeveynMi;
  bool bildirim;
  DateTime sonGirisTarihi;

  factory KullaniciAnything.fromJson(Map<String, dynamic> json) => KullaniciAnything(
        id: json["_id"],
        telefon: json["telefon"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
        ozelNot: json["ozelNot"],
        ebeveynMi: json["ebeveynMi"],
        bildirim: json["bildirim"],
        sonGirisTarihi: DateTime.parse(json["sonGirisTarihi"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "telefon": telefon,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
        "ozelNot": ozelNot,
        "ebeveynMi": ebeveynMi,
        "bildirim": bildirim,
        "sonGirisTarihi": sonGirisTarihi.toIso8601String(),
      };
}
