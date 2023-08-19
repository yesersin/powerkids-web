// To parse this JSON data, do
//
//     final modelOzelBeslenme = modelOzelBeslenmeFromJson(jsonString);

import 'dart:convert';

ModelOzelBeslenme modelOzelBeslenmeFromJson(String str) =>
    ModelOzelBeslenme.fromJson(json.decode(str));

String modelOzelBeslenmeToJson(ModelOzelBeslenme data) => json.encode(data.toJson());

class ModelOzelBeslenme {
  ModelOzelBeslenme({
    required this.success,
    required this.data,
  });

  int success;
  List<OzelBeslenme> data;

  factory ModelOzelBeslenme.fromJson(Map<String, dynamic> json) => ModelOzelBeslenme(
        success: json["success"],
        data: List<OzelBeslenme>.from(json["data"].map((x) => OzelBeslenme.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OzelBeslenme {
  OzelBeslenme({
    required this.id,
    required this.okulId,
    required this.ogrenciId,
    required this.yil,
    required this.ay,
    required this.gun,
    required this.ogun,
    required this.yemek,
    required this.dil,
    required this.goruldu,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String ogrenciId;
  int yil;
  int ay;
  int gun;
  int ogun;
  String yemek;
  String dil;
  bool goruldu;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory OzelBeslenme.fromJson(Map<String, dynamic> json) => OzelBeslenme(
        id: json["_id"],
        okulId: json["okulId"],
        ogrenciId: json["ogrenciId"],
        yil: json["yil"],
        ay: json["ay"],
        gun: json["gun"],
        ogun: json["ogun"],
        yemek: json["yemek"],
        dil: json["dil"],
        goruldu: json["goruldu"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "ogrenciId": ogrenciId,
        "yil": yil,
        "ay": ay,
        "gun": gun,
        "ogun": ogun,
        "yemek": yemek,
        "dil": dil,
        "goruldu": goruldu,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
