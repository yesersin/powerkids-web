// To parse this JSON data, do
//
//     final modelOgrenciKarti = modelOgrenciKartiFromJson(jsonString);

import 'dart:convert';

ModelOgrenciKarti modelOgrenciKartiFromJson(String str) =>
    ModelOgrenciKarti.fromJson(json.decode(str));

String modelOgrenciKartiToJson(ModelOgrenciKarti data) => json.encode(data.toJson());

class ModelOgrenciKarti {
  ModelOgrenciKarti({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOgrenciKarti.fromJson(Map<String, dynamic> json) => ModelOgrenciKarti(
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
    required this.ogrenciId,
    required this.okulId,
    required this.kayitZamani,
    required this.durum,
    required this.aileFormu,
    required this.boykilo,
    required this.detay,
    required this.psikolog,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String ogrenciId;
  String okulId;
  DateTime kayitZamani;
  bool durum;
  AileFormu aileFormu;
  List<Boykilo> boykilo;
  Detay detay;
  List<Psikolog> psikolog;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        ogrenciId: json["ogrenciId"],
        okulId: json["okulId"],
        kayitZamani: DateTime.parse(json["kayitZamani"]),
        durum: json["durum"],
        aileFormu: AileFormu.fromJson(json["aileFormu"]),
        boykilo: List<Boykilo>.from(json["boykilo"].map((x) => Boykilo.fromJson(x))),
        detay: Detay.fromJson(json["detay"]),
        psikolog: List<Psikolog>.from(json["psikolog"].map((x) => Psikolog.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ogrenciId": ogrenciId,
        "okulId": okulId,
        "kayitZamani": kayitZamani.toIso8601String(),
        "durum": durum,
        "aileFormu": aileFormu.toJson(),
        "boykilo": List<dynamic>.from(boykilo.map((x) => x.toJson())),
        "detay": detay.toJson(),
        "psikolog": List<dynamic>.from(psikolog.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class AileFormu {
  AileFormu({
    required this.ozelNot,
    required this.yemekEgitimi,
    required this.alerjikDurumu,
    required this.korkulari,
    required this.tuvaletEgitimi,
    required this.saglikDurumu,
    required this.aliskanliklari,
  });

  String ozelNot;
  String yemekEgitimi;
  String alerjikDurumu;
  String korkulari;
  String tuvaletEgitimi;
  String saglikDurumu;
  String aliskanliklari;

  factory AileFormu.fromJson(Map<String, dynamic> json) => AileFormu(
        ozelNot: json["ozelNot"],
        yemekEgitimi: json["yemekEgitimi"],
        alerjikDurumu: json["alerjikDurumu"],
        korkulari: json["korkulari"],
        tuvaletEgitimi: json["tuvaletEgitimi"],
        saglikDurumu: json["saglikDurumu"],
        aliskanliklari: json["aliskanliklari"],
      );

  Map<String, dynamic> toJson() => {
        "ozelNot": ozelNot,
        "yemekEgitimi": yemekEgitimi,
        "alerjikDurumu": alerjikDurumu,
        "korkulari": korkulari,
        "tuvaletEgitimi": tuvaletEgitimi,
        "saglikDurumu": saglikDurumu,
        "aliskanliklari": aliskanliklari,
      };
}

class Boykilo {
  Boykilo({
    required this.boy,
    required this.kilo,
    required this.ekleyenId,
    required this.durum,
    required this.id,
    required this.tarih,
  });

  int boy;
  int kilo;
  String ekleyenId;
  bool durum;
  String id;
  DateTime tarih;

  factory Boykilo.fromJson(Map<String, dynamic> json) => Boykilo(
        boy: json["boy"],
        kilo: json["kilo"],
        ekleyenId: json["ekleyenId"],
        durum: json["durum"],
        id: json["_id"],
        tarih: DateTime.parse(json["tarih"]),
      );

  Map<String, dynamic> toJson() => {
        "boy": boy,
        "kilo": kilo,
        "ekleyenId": ekleyenId,
        "durum": durum,
        "_id": id,
        "tarih": tarih.toIso8601String(),
      };
}

class Detay {
  Detay({
    required this.saglikNotu,
    required this.uyeTipi,
    required this.ulasimTipi,
    required this.veliEgitimDurumu,
    required this.evAdresi,
    required this.ailedurumu,
  });

  String saglikNotu;
  String uyeTipi;
  String ulasimTipi;
  String veliEgitimDurumu;
  String evAdresi;
  String ailedurumu;

  factory Detay.fromJson(Map<String, dynamic> json) => Detay(
        saglikNotu: json["saglikNotu"],
        uyeTipi: json["uyeTipi"],
        ulasimTipi: json["ulasimTipi"],
        veliEgitimDurumu: json["veliEgitimDurumu"],
        evAdresi: json["evAdresi"],
        ailedurumu: json["ailedurumu"],
      );

  Map<String, dynamic> toJson() => {
        "saglikNotu": saglikNotu,
        "uyeTipi": uyeTipi,
        "ulasimTipi": ulasimTipi,
        "veliEgitimDurumu": veliEgitimDurumu,
        "evAdresi": evAdresi,
        "ailedurumu": ailedurumu,
      };
}

class Psikolog {
  Psikolog({
    required this.veliGorsunmu,
    required this.isBirligi,
    required this.sonuc,
    required this.gorusmeKonusu,
    required this.durum,
    required this.id,
    required this.gorusmeTarihi,
  });

  bool veliGorsunmu;
  String isBirligi;
  String sonuc;
  String gorusmeKonusu;
  bool durum;
  String id;
  DateTime gorusmeTarihi;

  factory Psikolog.fromJson(Map<String, dynamic> json) => Psikolog(
        veliGorsunmu: json["veliGorsunmu"],
        isBirligi: json["isBirligi"],
        sonuc: json["sonuc"],
        gorusmeKonusu: json["gorusmeKonusu"],
        durum: json["durum"],
        id: json["_id"],
        gorusmeTarihi: DateTime.parse(json["gorusmeTarihi"]),
      );

  Map<String, dynamic> toJson() => {
        "veliGorsunmu": veliGorsunmu,
        "isBirligi": isBirligi,
        "sonuc": sonuc,
        "gorusmeKonusu": gorusmeKonusu,
        "durum": durum,
        "_id": id,
        "gorusmeTarihi": gorusmeTarihi.toIso8601String(),
      };
}
