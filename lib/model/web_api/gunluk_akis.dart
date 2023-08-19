// To parse this JSON data, do
//
//     final modelGunlukAkis = modelGunlukAkisFromJson(jsonString);

import 'dart:convert';

ModelGunlukAkis modelGunlukAkisFromJson(String str) =>
    ModelGunlukAkis.fromJson(json.decode(str));

String modelGunlukAkisToJson(ModelGunlukAkis data) => json.encode(data.toJson());

class ModelGunlukAkis {
  ModelGunlukAkis({
    required this.success,
    required this.data,
  });

  int success;
  List<GunlukAkisData> data;

  factory ModelGunlukAkis.fromJson(Map<String, dynamic> json) => ModelGunlukAkis(
        success: json["success"],
        data: List<GunlukAkisData>.from(json["data"].map((x) => GunlukAkisData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GunlukAkisData {
  GunlukAkisData({
    required this.id,
    required this.okulId,
    required this.tarihSaat,
    required this.sinifId,
    required this.ekleyenId,
    required this.aciklama,
    required this.baslik,
    required this.url,
    required this.gordu,
    required this.onaylamaIzni,
    required this.onayDurum,
    required this.begendi,
    required this.donem,
    required this.tip,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GunlukAkisData.empty() {
    return GunlukAkisData(
        id: "",
        okulId: "",
        tarihSaat: DateTime.now(),
        sinifId: "",
        ekleyenId: "",
        aciklama: "",
        baslik: "baslik",
        url: [],
        gordu: [],
        onaylamaIzni: true,
        onayDurum: false,
        begendi: [],
        donem: "donem",
        tip: 1,
        durum: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 1);
  }

  String id;
  String okulId;
  DateTime tarihSaat;
  String sinifId;
  String ekleyenId;
  String aciklama;
  String baslik;
  List<String> url;
  List<String> gordu;
  bool onaylamaIzni;
  bool onayDurum;
  List<String> begendi;
  String donem;
  int tip;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory GunlukAkisData.fromJson(Map<String, dynamic> json) => GunlukAkisData(
        id: json["_id"],
        okulId: json["okulId"],
        tarihSaat: DateTime.parse(json["tarihSaat"]),
        sinifId: json["sinifId"],
        ekleyenId: json["ekleyenId"],
        aciklama: json["aciklama"],
        baslik: json["baslik"],
        url: List<String>.from(json["url"].map((x) => x)),
        gordu: List<String>.from(json["gordu"].map((x) => x)),
        onaylamaIzni: json["onaylamaIzni"],
        onayDurum: json["onayDurum"],
        begendi: List<String>.from(json["begendi"].map((x) => x)),
        donem: json["donem"],
        tip: json["tip"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "tarihSaat": tarihSaat.toIso8601String(),
        "sinifId": sinifId,
        "ekleyenId": ekleyenId,
        "aciklama": aciklama,
        "baslik": baslik,
        "url": List<dynamic>.from(url.map((x) => x)),
        "gordu": List<dynamic>.from(gordu.map((x) => x)),
        "onaylamaIzni": onaylamaIzni,
        "onayDurum": onayDurum,
        "begendi": List<dynamic>.from(begendi.map((x) => x)),
        "donem": donem,
        "tip": tip,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
