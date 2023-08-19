// To parse this JSON data, do
//
//     final modelMesajEsleVeliOgretmen = modelMesajEsleVeliOgretmenFromJson(jsonString);

import 'dart:convert';

ModelMesajEsleVeliOgretmen modelMesajEsleVeliOgretmenFromJson(String str) =>
    ModelMesajEsleVeliOgretmen.fromJson(json.decode(str));

String modelMesajEsleVeliOgretmenToJson(ModelMesajEsleVeliOgretmen data) =>
    json.encode(data.toJson());

class ModelMesajEsleVeliOgretmen {
  ModelMesajEsleVeliOgretmen({
    required this.success,
    required this.data,
  });

  int success;
  List<MesajEsleVeliOgretmenData> data;

  factory ModelMesajEsleVeliOgretmen.fromJson(Map<String, dynamic> json) =>
      ModelMesajEsleVeliOgretmen(
        success: json["success"],
        data: List<MesajEsleVeliOgretmenData>.from(
            json["data"].map((x) => MesajEsleVeliOgretmenData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MesajEsleVeliOgretmenData {
  MesajEsleVeliOgretmenData({
    required this.id,
    required this.okulId,
    required this.veliId,
    required this.guncellemeZamani,
    required this.ogretmenId,
    required this.vOkunmayan,
    required this.oOkunmayan,
    required this.sonMesaj,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String veliId;
  DateTime guncellemeZamani;
  String ogretmenId;
  int vOkunmayan;
  int oOkunmayan;
  String sonMesaj;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory MesajEsleVeliOgretmenData.fromJson(Map<String, dynamic> json) =>
      MesajEsleVeliOgretmenData(
        id: json["_id"],
        okulId: json["okulId"],
        veliId: json["veliId"],
        guncellemeZamani: DateTime.parse(json["guncellemeZamani"]),
        ogretmenId: json["ogretmenId"],
        vOkunmayan: json["vOkunmayan"],
        oOkunmayan: json["oOkunmayan"],
        sonMesaj: json["sonMesaj"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "veliId": veliId,
        "guncellemeZamani": guncellemeZamani.toIso8601String(),
        "ogretmenId": ogretmenId,
        "vOkunmayan": vOkunmayan,
        "oOkunmayan": oOkunmayan,
        "sonMesaj": sonMesaj,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
