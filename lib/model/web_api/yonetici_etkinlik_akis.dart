// To parse this JSON data, do
//
//     final modelYoneticiEtkinlikAkis = modelYoneticiEtkinlikAkisFromJson(jsonString);

import 'dart:convert';

ModelYoneticiEtkinlikAkis modelYoneticiEtkinlikAkisFromJson(String str) =>
    ModelYoneticiEtkinlikAkis.fromJson(json.decode(str));

String modelYoneticiEtkinlikAkisToJson(ModelYoneticiEtkinlikAkis data) =>
    json.encode(data.toJson());

class ModelYoneticiEtkinlikAkis {
  ModelYoneticiEtkinlikAkis({
    required this.success,
    required this.data,
  });

  int success;
  List<YoneticiEtkinlikAkisData> data;

  factory ModelYoneticiEtkinlikAkis.fromJson(Map<String, dynamic> json) =>
      ModelYoneticiEtkinlikAkis(
        success: json["success"],
        data: List<YoneticiEtkinlikAkisData>.from(
            json["data"].map((x) => YoneticiEtkinlikAkisData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class YoneticiEtkinlikAkisData {
  YoneticiEtkinlikAkisData({
    required this.id,
    required this.etkinlikAdi,
    required this.ogretmenAdi,
    required this.ogrenciSayisi,
    required this.zaman,
  });

  String id;
  String etkinlikAdi;
  String ogretmenAdi;
  int ogrenciSayisi;
  DateTime zaman;

  factory YoneticiEtkinlikAkisData.fromJson(Map<String, dynamic> json) =>
      YoneticiEtkinlikAkisData(
        id: json["_id"],
        etkinlikAdi: json["etkinlikAdi"],
        ogretmenAdi: json["ogretmenAdi"],
        ogrenciSayisi: json["ogrenciSayisi"],
        zaman: DateTime.parse(json["zaman"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "etkinlikAdi": etkinlikAdi,
        "ogretmenAdi": ogretmenAdi,
        "ogrenciSayisi": ogrenciSayisi,
        "zaman": zaman.toIso8601String(),
      };
}
