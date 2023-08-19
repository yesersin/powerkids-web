// To parse this JSON data, do
//
//     final modelDuyuruAddCevap = modelDuyuruAddCevapFromJson(jsonString);

import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_gelen.dart';

ModelDuyuruAddCevap modelDuyuruAddCevapFromJson(String str) =>
    ModelDuyuruAddCevap.fromJson(json.decode(str));

String modelDuyuruAddCevapToJson(ModelDuyuruAddCevap data) => json.encode(data.toJson());

class ModelDuyuruAddCevap {
  ModelDuyuruAddCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelDuyuruAddCevap.fromJson(Map<String, dynamic> json) => ModelDuyuruAddCevap(
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
    required this.sinifId,
    required this.sonYayinZamani,
    required this.ekleyenId,
    required this.ekleyenAd,
    required this.baslik,
    required this.aciklama,
    required this.dosya,
    required this.ebeveyn,
    required this.onayDurum,
    required this.dil,
    required this.oncelik,
    required this.pin,
    required this.veliOnayDurum,
    required this.veliRedDurum,
    required this.durum,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String okulId;
  String sinifId;
  DateTime sonYayinZamani;
  String ekleyenId;
  String ekleyenAd;
  String baslik;
  String aciklama;
  List<String> dosya;
  bool ebeveyn;
  bool onayDurum;
  String dil;
  int oncelik;
  bool pin;
  List<String> veliOnayDurum;
  List<String> veliRedDurum;
  bool durum;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        sonYayinZamani: DateTime.parse(json["sonYayinZamani"]),
        ekleyenId: json["ekleyenId"],
        ekleyenAd: json["ekleyenAd"],
        baslik: json["baslik"],
        aciklama: json["aciklama"],
        dosya: List<String>.from(json["dosya"].map((x) => x)),
        ebeveyn: json["ebeveyn"],
        onayDurum: json["onayDurum"],
        dil: json["dil"],
        oncelik: json["oncelik"],
        pin: json["pin"],
        veliOnayDurum: List<String>.from(json["veliOnayDurum"].map((x) => x)),
        veliRedDurum: List<String>.from(json["veliRedDurum"].map((x) => x)),
        durum: json["durum"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "okulId": okulId,
        "sinifId": sinifId,
        "sonYayinZamani": sonYayinZamani.toIso8601String(),
        "ekleyenId": ekleyenId,
        "ekleyenAd": ekleyenAd,
        "baslik": baslik,
        "aciklama": aciklama,
        "dosya": List<String>.from(dosya.map((x) => x)),
        "ebeveyn": ebeveyn,
        "onayDurum": onayDurum,
        "dil": dil,
        "oncelik": oncelik,
        "pin": pin,
        "veliOnayDurum": List<String>.from(veliOnayDurum.map((x) => x)),
        "veliRedDurum": List<String>.from(veliRedDurum.map((x) => x)),
        "durum": durum,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };

  ModelDuyuru duyuruyaCevir() {
    return ModelDuyuru(
        id: id,
        okulId: okulId,
        sinifId: sinifId,
        sonYayinZamani: sonYayinZamani,
        ekleyenId: ekleyenId,
        ekleyenAd: ekleyenAd,
        baslik: baslik,
        aciklama: aciklama,
        dosya: dosya,
        ebeveyn: ebeveyn,
        dil: dil,
        oncelik: oncelik,
        pin: pin,
        onayDurum: onayDurum,
        durum: durum,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: v,
        veliRedDurum: veliRedDurum,
        veliOnayDurum: veliOnayDurum);
  }
}
