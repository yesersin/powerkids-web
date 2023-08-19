// To parse this JSON data, do
//
//     final modelOkulSiniflari = modelOkulSiniflariFromJson(jsonString);

import 'dart:convert';

ModelOkulSiniflari modelOkulSiniflariFromJson(String str) =>
    ModelOkulSiniflari.fromJson(json.decode(str));

String modelOkulSiniflariToJson(ModelOkulSiniflari data) => json.encode(data.toJson());

class ModelOkulSiniflari {
  ModelOkulSiniflari({
    required this.success,
    required this.data,
  });

  int success;
  List<ModelSinif> data;

  factory ModelOkulSiniflari.fromJson(Map<String, dynamic> json) => ModelOkulSiniflari(
        success: json["success"],
        data: List<ModelSinif>.from(json["data"].map((x) => ModelSinif.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ModelSinif {
  ModelSinif({
    required this.id,
    required this.okulId,
    required this.sinifAdi,
    required this.durum,
    required this.donem,
    required this.updatedAt,
    required this.v,
    required this.createdAt,
  });

  String id;
  String okulId;
  String sinifAdi;
  bool durum;
  String donem;
  DateTime updatedAt;
  int v;
  DateTime createdAt;

  factory ModelSinif.fromJson(Map<String, dynamic> json) => ModelSinif(
        id: json["_id"],
        okulId: json["okulId"],
        sinifAdi: json["sinifAdi"],
        durum: json["durum"],
        donem: json["donem"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifAdi": sinifAdi,
        "durum": durum,
        "donem": donem,
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
      };
}
