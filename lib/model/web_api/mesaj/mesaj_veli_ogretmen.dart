// To parse this JSON data, do
//
//     final modelMesajVeliOgretmen = modelMesajVeliOgretmenFromJson(jsonString);

import 'dart:convert';

ModelMesajVeliOgretmen modelMesajVeliOgretmenFromJson(String str) =>
    ModelMesajVeliOgretmen.fromJson(json.decode(str));

String modelMesajVeliOgretmenToJson(ModelMesajVeliOgretmen data) => json.encode(data.toJson());

class ModelMesajVeliOgretmen {
  ModelMesajVeliOgretmen({
    required this.success,
    required this.data,
  });

  int success;
  List<MesajData> data;

  factory ModelMesajVeliOgretmen.fromJson(Map<String, dynamic> json) => ModelMesajVeliOgretmen(
        success: json["success"],
        data: List<MesajData>.from(json["data"].map((x) => MesajData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MesajData {
  MesajData({
    required this.id,
    required this.gid,
    required this.mesajEsleId,
    required this.mesaj,
    required this.media,
    required this.tip,
    required this.silindi,
    required this.goruldu,
    required this.adSoyad,
    required this.yetki,
    required this.zaman,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String gid;
  String mesajEsleId;
  String mesaj;
  String media;
  String tip;
  bool silindi;
  bool goruldu;
  String adSoyad;
  String yetki;
  DateTime zaman;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory MesajData.fromJson(Map<String, dynamic> json) => MesajData(
        id: json["_id"],
        gid: json["gid"],
        mesajEsleId: json["mesajEsleId"],
        mesaj: json["mesaj"],
        media: json["media"],
        tip: json["tip"],
        silindi: json["silindi"],
        goruldu: json["goruldu"],
        adSoyad: json["adSoyad"],
        yetki: json["yetki"],
        zaman: DateTime.parse(json["zaman"]),
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "gid": gid,
        "mesajEsleId": mesajEsleId,
        "mesaj": mesaj,
        "media": media,
        "tip": tip,
        "silindi": silindi,
        "goruldu": goruldu,
        "adSoyad": adSoyad,
        "yetki": yetki,
        "zaman": zaman.toIso8601String(),
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
