// To parse this JSON data, do
//
//     final modelAnketCevap = modelAnketCevapFromJson(jsonString);

import 'dart:convert';

ModelAnketCevap modelAnketCevapFromJson(String str) =>
    ModelAnketCevap.fromJson(json.decode(str));

String modelAnketCevapToJson(ModelAnketCevap data) => json.encode(data.toJson());

class ModelAnketCevap {
  ModelAnketCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelAnketCevap.fromJson(Map<String, dynamic> json) => ModelAnketCevap(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.anketId,
    required this.okulId,
    required this.kullaniciId,
    required this.birCevap,
    required this.ikiCevap,
    required this.ucCevap,
    required this.dortCevap,
    required this.dil,
    required this.puan,
    required this.durum,
    required this.id,
    required this.zaman,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String anketId;
  String okulId;
  String kullaniciId;
  String birCevap;
  String ikiCevap;
  String ucCevap;
  String dortCevap;
  String dil;
  int puan;
  bool durum;
  String id;
  DateTime zaman;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        anketId: json["anketId"],
        okulId: json["okulId"],
        kullaniciId: json["kullaniciId"],
        birCevap: json["birCevap"],
        ikiCevap: json["ikiCevap"],
        ucCevap: json["ucCevap"],
        dortCevap: json["dortCevap"],
        dil: json["dil"],
        puan: json["puan"],
        durum: json["durum"],
        id: json["_id"],
        zaman: DateTime.parse(json["zaman"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "anketId": anketId,
        "okulId": okulId,
        "kullaniciId": kullaniciId,
        "birCevap": birCevap,
        "ikiCevap": ikiCevap,
        "ucCevap": ucCevap,
        "dortCevap": dortCevap,
        "dil": dil,
        "puan": puan,
        "durum": durum,
        "_id": id,
        "zaman": zaman.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
