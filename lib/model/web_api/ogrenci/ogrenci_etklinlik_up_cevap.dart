// To parse this JSON data, do
//
//     final modelOgrenciEtkinlikUpCevap = modelOgrenciEtkinlikUpCevapFromJson(jsonString);

import 'dart:convert';

ModelOgrenciEtkinlikUpCevap modelOgrenciEtkinlikUpCevapFromJson(String str) =>
    ModelOgrenciEtkinlikUpCevap.fromJson(json.decode(str));

String modelOgrenciEtkinlikUpCevapToJson(ModelOgrenciEtkinlikUpCevap data) =>
    json.encode(data.toJson());

class ModelOgrenciEtkinlikUpCevap {
  ModelOgrenciEtkinlikUpCevap({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOgrenciEtkinlikUpCevap.fromJson(Map<String, dynamic> json) =>
      ModelOgrenciEtkinlikUpCevap(
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
    required this.id,
    required this.okulId,
    required this.ogrenciId,
    required this.psikolog,
    required this.boykilo,
  });

  String id;
  String okulId;
  String ogrenciId;
  Psikolog psikolog;
  BoykiloUpCevap boykilo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        okulId: json["okulId"],
        ogrenciId: json["ogrenciId"],
        psikolog: Psikolog.fromJson(json["psikolog"]),
        boykilo: BoykiloUpCevap.fromJson(json["boykilo"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "ogrenciId": ogrenciId,
        "psikolog": psikolog.toJson(),
        "boykilo": boykilo.toJson(),
      };
}

class BoykiloUpCevap {
  BoykiloUpCevap({
    required this.boy,
    required this.kilo,
    required this.ekleyenId,
  });

  String boy;
  String kilo;
  String ekleyenId;

  factory BoykiloUpCevap.fromJson(Map<String, dynamic> json) => BoykiloUpCevap(
        boy: json["boy"],
        kilo: json["kilo"],
        ekleyenId: json["ekleyenId"],
      );

  Map<String, dynamic> toJson() => {
        "boy": boy,
        "kilo": kilo,
        "ekleyenId": ekleyenId,
      };
}

class Psikolog {
  Psikolog({
    required this.isBirligi,
    required this.gorusmeKonusu,
    required this.sonuc,
    required this.veliGorsunmu,
    required this.gorusmeTarihi,
  });

  String isBirligi;
  String gorusmeKonusu;
  String sonuc;
  bool veliGorsunmu;
  String gorusmeTarihi;

  factory Psikolog.fromJson(Map<String, dynamic> json) => Psikolog(
        isBirligi: json["isBirligi"],
        gorusmeKonusu: json["gorusmeKonusu"],
        sonuc: json["sonuc"],
        veliGorsunmu: json["veliGorsunmu"],
        gorusmeTarihi: json["gorusmeTarihi"],
      );

  Map<String, dynamic> toJson() => {
        "isBirligi": isBirligi,
        "gorusmeKonusu": gorusmeKonusu,
        "sonuc": sonuc,
        "veliGorsunmu": veliGorsunmu,
        "gorusmeTarihi": gorusmeTarihi,
      };
}
