// To parse this JSON data, do
//
//     final modelOkul = modelOkulFromJson(jsonString);

import 'dart:convert';

ModelOkul modelOkulFromJson(String str) => ModelOkul.fromJson(json.decode(str));

String modelOkulToJson(ModelOkul data) => json.encode(data.toJson());

class ModelOkul {
  ModelOkul({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOkul.fromJson(Map<String, dynamic> json) => ModelOkul(
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
    required this.okulAdi,
    required this.skt,
    required this.anlasma,
    required this.paytr,
    required this.kayitTarihi,
    required this.kayitDurum,
    required this.telefon,
    required this.faturaBilgi,
    required this.durum,
    required this.uyelikDurum,
    required this.adres,
    required this.logo,
    required this.ogrenciSayisi,
    required this.mail,
    required this.whatsapp,
    required this.aciklama,
    required this.aktifDonem,
    required this.firmaId,
  });

  String id;
  String okulAdi;
  DateTime skt;
  String anlasma;
  Paytr paytr;
  DateTime kayitTarihi;
  bool kayitDurum;
  String telefon;
  FaturaBilgi faturaBilgi;
  bool durum;
  String uyelikDurum;
  Adres adres;
  String logo;
  int ogrenciSayisi;
  String mail;
  String whatsapp;
  String aciklama;
  String aktifDonem;
  String firmaId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        okulAdi: json["okulAdi"],
        skt: DateTime.parse(json["skt"]),
        anlasma: json["anlasma"],
        paytr: Paytr.fromJson(json["paytr"]),
        kayitTarihi: DateTime.parse(json["kayitTarihi"]),
        kayitDurum: json["kayitDurum"],
        telefon: json["telefon"],
        faturaBilgi: FaturaBilgi.fromJson(json["faturaBilgi"]),
        durum: json["durum"],
        uyelikDurum: json["uyelikDurum"],
        adres: Adres.fromJson(json["adres"]),
        logo: json["logo"],
        ogrenciSayisi: json["ogrenciSayisi"],
        mail: json["mail"],
        whatsapp: json["whatsapp"],
        aciklama: json["aciklama"],
        aktifDonem: json["aktifDonem"],
        firmaId: json["firmaId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulAdi": okulAdi,
        "skt": skt.toIso8601String(),
        "anlasma": anlasma,
        "paytr": paytr.toJson(),
        "kayitTarihi": kayitTarihi.toIso8601String(),
        "kayitDurum": kayitDurum,
        "telefon": telefon,
        "faturaBilgi": faturaBilgi.toJson(),
        "durum": durum,
        "uyelikDurum": uyelikDurum,
        "adres": adres.toJson(),
        "logo": logo,
        "ogrenciSayisi": ogrenciSayisi,
        "mail": mail,
        "whatsapp": whatsapp,
        "aciklama": aciklama,
        "aktifDonem": aktifDonem,
        "firmaId": firmaId,
      };
}

class Adres {
  Adres({
    required this.lat,
    required this.lng,
    required this.acikadres,
  });

  double lat;
  double lng;
  String acikadres;

  factory Adres.fromJson(Map<String, dynamic> json) => Adres(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        acikadres: json["acikadres"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "acikadres": acikadres,
      };
}

class FaturaBilgi {
  FaturaBilgi({
    required this.faturaAdres,
    required this.sirketAdi,
    required this.vergiDairesi,
    required this.tip,
    required this.vergiNo,
  });

  String faturaAdres;
  String sirketAdi;
  String vergiDairesi;
  String tip;
  String vergiNo;

  factory FaturaBilgi.fromJson(Map<String, dynamic> json) => FaturaBilgi(
        faturaAdres: json["faturaAdres"],
        sirketAdi: json["sirketAdi"],
        vergiDairesi: json["vergiDairesi"],
        tip: json["tip"],
        vergiNo: json["vergiNo"],
      );

  Map<String, dynamic> toJson() => {
        "faturaAdres": faturaAdres,
        "sirketAdi": sirketAdi,
        "vergiDairesi": vergiDairesi,
        "tip": tip,
        "vergiNo": vergiNo,
      };
}

class Paytr {
  Paytr({
    required this.merchantSalt,
    required this.merchantId,
    required this.merchantKey,
  });

  String merchantSalt;
  String merchantId;
  String merchantKey;

  factory Paytr.fromJson(Map<String, dynamic> json) => Paytr(
        merchantSalt: json["merchant_salt"],
        merchantId: json["merchant_id"],
        merchantKey: json["merchant_key"],
      );

  Map<String, dynamic> toJson() => {
        "merchant_salt": merchantSalt,
        "merchant_id": merchantId,
        "merchant_key": merchantKey,
      };
}
