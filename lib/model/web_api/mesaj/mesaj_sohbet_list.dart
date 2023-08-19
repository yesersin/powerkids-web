// To parse this JSON data, do
//
//     final modelMesajSohbetList = modelMesajSohbetListFromJson(jsonString);

import 'dart:convert';

ModelMesajSohbetList modelMesajSohbetListFromJson(String str) =>
    ModelMesajSohbetList.fromJson(json.decode(str));

String modelMesajSohbetListToJson(ModelMesajSohbetList data) => json.encode(data.toJson());

class ModelMesajSohbetList {
  ModelMesajSohbetList({
    required this.success,
    required this.data,
  });

  int success;
  List<MesajSohbetData> data;

  factory ModelMesajSohbetList.fromJson(Map<String, dynamic> json) => ModelMesajSohbetList(
        success: json["success"],
        data: List<MesajSohbetData>.from(json["data"].map((x) => MesajSohbetData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MesajSohbetData {
  MesajSohbetData({
    required this.id,
    required this.okulId,
    required this.sonMesaj,
    required this.veliId,
    required this.guncellemeZamani,
    required this.ogretmenId,
    required this.vOkunmayan,
    required this.oOkunmayan,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String okulId;
  String sonMesaj;
  Id veliId;
  DateTime guncellemeZamani;
  Id ogretmenId;
  int vOkunmayan;
  int oOkunmayan;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory MesajSohbetData.fromJson(Map<String, dynamic> json) => MesajSohbetData(
        id: json["_id"],
        okulId: json["okulId"],
        sonMesaj: json["sonMesaj"],
        veliId: Id.fromJson(json["veliId"]),
        guncellemeZamani: DateTime.parse(json["guncellemeZamani"]),
        ogretmenId: Id.fromJson(json["ogretmenId"]),
        vOkunmayan: json["vOkunmayan"],
        oOkunmayan: json["oOkunmayan"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sonMesaj": sonMesaj,
        "veliId": veliId.toJson(),
        "guncellemeZamani": guncellemeZamani.toIso8601String(),
        "ogretmenId": ogretmenId.toJson(),
        "vOkunmayan": vOkunmayan,
        "oOkunmayan": oOkunmayan,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Id {
  Id({
    required this.id,
    required this.notificationId,
    required this.adSoyad,
    required this.fotografUrl,
  });

  String id;
  String notificationId;
  String adSoyad;
  String fotografUrl;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        id: json["_id"],
        notificationId: json["notificationId"],
        adSoyad: json["adSoyad"],
        fotografUrl: json["fotografUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "notificationId": notificationId,
        "adSoyad": adSoyad,
        "fotografUrl": fotografUrl,
      };
}
