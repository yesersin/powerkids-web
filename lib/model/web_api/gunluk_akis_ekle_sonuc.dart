// To parse this JSON data, do
//
//     final modelGunlukAkisEkleSonuc = modelGunlukAkisEkleSonucFromJson(jsonString);

import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/gunluk_akis.dart';

ModelGunlukAkisEkleSonuc modelGunlukAkisEkleSonucFromJson(String str) =>
    ModelGunlukAkisEkleSonuc.fromJson(json.decode(str));

String modelGunlukAkisEkleSonucToJson(ModelGunlukAkisEkleSonuc data) =>
    json.encode(data.toJson());

class ModelGunlukAkisEkleSonuc {
  ModelGunlukAkisEkleSonuc({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelGunlukAkisEkleSonuc.fromJson(Map<String, dynamic> json) =>
      ModelGunlukAkisEkleSonuc(
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
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  GunlukAkisData akisaCevir() {
    return GunlukAkisData(
        id: id,
        okulId: okulId,
        tarihSaat: tarihSaat,
        sinifId: sinifId,
        ekleyenId: ekleyenId,
        aciklama: aciklama,
        baslik: baslik,
        url: url,
        gordu: gordu,
        onaylamaIzni: onaylamaIzni,
        onayDurum: onayDurum,
        begendi: begendi,
        donem: donem,
        tip: tip,
        durum: durum,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v);
  }

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
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
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
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
