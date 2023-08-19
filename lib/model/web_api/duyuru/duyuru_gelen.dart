// To parse this JSON data, do
//
//     final modelDuyuruGelen = modelDuyuruGelenFromJson(jsonString);

import 'dart:convert';

ModelDuyuruGelen modelDuyuruGelenFromJson(String str) =>
    ModelDuyuruGelen.fromJson(json.decode(str));

String modelDuyuruGelenToJson(ModelDuyuruGelen data) => json.encode(data.toJson());

class ModelDuyuruGelen {
  ModelDuyuruGelen({
    required this.success,
    required this.data,
  });

  int success;
  List<ModelDuyuru> data;

  factory ModelDuyuruGelen.fromJson(Map<String, dynamic> json) => ModelDuyuruGelen(
        success: json["success"],
        data: List<ModelDuyuru>.from(json["data"].map((x) => ModelDuyuru.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ModelDuyuru {
  ModelDuyuru({
    required this.id,
    required this.okulId,
    required this.sinifId,
    required this.sonYayinZamani,
    required this.ekleyenId,
    required this.ekleyenAd,
    required this.baslik,
    required this.aciklama,
    required this.dosya,
    required this.ebeveyn,
    required this.dil,
    required this.oncelik,
    required this.pin,
    required this.onayDurum,
    required this.durum,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.veliRedDurum,
    required this.veliOnayDurum,
  });

  String id;
  String okulId;
  String sinifId;
  DateTime sonYayinZamani;
  String ekleyenId;
  String ekleyenAd;
  String baslik;
  String aciklama;
  List<dynamic> dosya;
  bool ebeveyn;
  String dil;
  int oncelik;
  bool pin;
  bool onayDurum;
  bool durum;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<String> veliRedDurum;
  List<String> veliOnayDurum;

  factory ModelDuyuru.fromJson(Map<String, dynamic> json) => ModelDuyuru(
        id: json["_id"],
        okulId: json["okulId"],
        sinifId: json["sinifId"],
        sonYayinZamani: DateTime.parse(json["sonYayinZamani"]),
        ekleyenId: json["ekleyenId"],
        ekleyenAd: json["ekleyenAd"],
        baslik: json["baslik"],
        aciklama: json["aciklama"],
        dosya: List<dynamic>.from(json["dosya"].map((x) => x)),
        ebeveyn: json["ebeveyn"],
        dil: json["dil"],
        oncelik: json["oncelik"],
        pin: json["pin"],
        onayDurum: json["onayDurum"],
        durum: json["durum"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        veliRedDurum: List<String>.from(json["veliRedDurum"].map((x) => x)),
        veliOnayDurum: List<String>.from(json["veliOnayDurum"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "sinifId": sinifId,
        "sonYayinZamani": sonYayinZamani.toIso8601String(),
        "ekleyenId": ekleyenId,
        "ekleyenAd": ekleyenAd,
        "baslik": baslik,
        "aciklama": aciklama,
        "dosya": List<dynamic>.from(dosya.map((x) => x)),
        "ebeveyn": ebeveyn,
        "dil": dil,
        "oncelik": oncelik,
        "pin": pin,
        "onayDurum": onayDurum,
        "durum": durum,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "veliRedDurum": List<dynamic>.from(veliRedDurum.map((x) => x)),
        "veliOnayDurum": List<dynamic>.from(veliOnayDurum.map((x) => x)),
      };
}
