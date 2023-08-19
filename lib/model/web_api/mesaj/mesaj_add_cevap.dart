// To parse this JSON data, do
//
//     final modelMesajAddCevap = modelMesajAddCevapFromJson(jsonString);

import 'dart:convert';

import 'mesaj_veli_ogretmen.dart';

ModelMesajAddCevap modelMesajAddCevapFromJson(String str) =>
    ModelMesajAddCevap.fromJson(json.decode(str));

String modelMesajAddCevapToJson(ModelMesajAddCevap data) => json.encode(data.toJson());

class ModelMesajAddCevap {
  ModelMesajAddCevap({
    required this.success,
    required this.data,
  });

  int success;
  MesajAddData data;

  factory ModelMesajAddCevap.fromJson(Map<String, dynamic> json) => ModelMesajAddCevap(
        success: json["success"],
        data: MesajAddData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class MesajAddData {
  MesajAddData({
    required this.gid,
    required this.okulId,
    required this.mesajEsleId,
    required this.mesaj,
    required this.media,
    required this.silindi,
    required this.goruldu,
    required this.adSoyad,
    required this.yetki,
    required this.tip,
    required this.zaman,
    required this.durum,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String gid;
  String okulId;
  String mesajEsleId;
  String mesaj;
  String media;
  bool silindi;
  bool goruldu;
  String adSoyad;
  String yetki;
  String tip;
  DateTime zaman;
  bool durum;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MesajData mesajDatayaDonustur() {
    return MesajData(
        id: id,
        gid: gid,
        mesajEsleId: mesajEsleId,
        mesaj: mesaj,
        media: media,
        tip: tip,
        silindi: silindi,
        goruldu: goruldu,
        adSoyad: adSoyad,
        yetki: yetki,
        zaman: zaman,
        durum: durum,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v);
  }

  factory MesajAddData.fromJson(Map<String, dynamic> json) => MesajAddData(
        gid: json["gid"],
        okulId: json["okulId"],
        mesajEsleId: json["mesajEsleId"],
        mesaj: json["mesaj"],
        media: json["media"],
        silindi: json["silindi"],
        goruldu: json["goruldu"],
        adSoyad: json["adSoyad"],
        yetki: json["yetki"],
        tip: json["tip"],
        zaman: DateTime.parse(json["zaman"]),
        durum: json["durum"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "gid": gid,
        "okulId": okulId,
        "mesajEsleId": mesajEsleId,
        "mesaj": mesaj,
        "media": media,
        "silindi": silindi,
        "goruldu": goruldu,
        "adSoyad": adSoyad,
        "yetki": yetki,
        "tip": tip,
        "zaman": zaman.toIso8601String(),
        "durum": durum,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
