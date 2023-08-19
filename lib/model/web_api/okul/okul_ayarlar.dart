// To parse this JSON data, do
//
//     final modelOkulAyarlar = modelOkulAyarlarFromJson(jsonString);

import 'dart:convert';

ModelOkulAyarlar modelOkulAyarlarFromJson(String str) =>
    ModelOkulAyarlar.fromJson(json.decode(str));

String modelOkulAyarlarToJson(ModelOkulAyarlar data) => json.encode(data.toJson());

class ModelOkulAyarlar {
  ModelOkulAyarlar({
    required this.success,
    required this.data,
  });

  int success;
  Data data;

  factory ModelOkulAyarlar.fromJson(Map<String, dynamic> json) => ModelOkulAyarlar(
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
    required this.cokluSinif,
    required this.canliYayinSayisi,
    required this.dersProgrami,
    required this.tarihLimit,
    required this.onaylamaIzni,
    required this.onaylamaKullaniciId,
    required this.odemeIzni,
    required this.veliButonlar,
    required this.ogretmenButonlari,
    required this.servisAdet,
    required this.mesajyon,
    required this.donem,
    required this.okulId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  bool cokluSinif;
  int canliYayinSayisi;
  String dersProgrami;
  int tarihLimit;
  bool onaylamaIzni;
  List<String> onaylamaKullaniciId;
  bool odemeIzni;
  Map<String, bool> veliButonlar;
  Map<String, bool> ogretmenButonlari;
  int servisAdet;
  String mesajyon;
  String donem;
  String okulId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        cokluSinif: json["cokluSinif"],
        canliYayinSayisi: json["canliYayinSayisi"],
        dersProgrami: json["dersProgrami"],
        tarihLimit: json["tarihLimit"],
        onaylamaIzni: json["onaylamaIzni"],
        onaylamaKullaniciId: List<String>.from(json["onaylamaKullaniciId"].map((x) => x)),
        odemeIzni: json["odemeIzni"],
        veliButonlar:
            Map.from(json["veliButonlar"]).map((k, v) => MapEntry<String, bool>(k, v)),
        ogretmenButonlari:
            Map.from(json["ogretmenButonlari"]).map((k, v) => MapEntry<String, bool>(k, v)),
        servisAdet: json["servisAdet"],
        mesajyon: json["mesajyon"],
        donem: json["donem"],
        okulId: json["okulId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cokluSinif": cokluSinif,
        "canliYayinSayisi": canliYayinSayisi,
        "dersProgrami": dersProgrami,
        "tarihLimit": tarihLimit,
        "onaylamaIzni": onaylamaIzni,
        "onaylamaKullaniciId": List<dynamic>.from(onaylamaKullaniciId.map((x) => x)),
        "odemeIzni": odemeIzni,
        "veliButonlar": Map.from(veliButonlar).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ogretmenButonlari":
            Map.from(ogretmenButonlari).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "servisAdet": servisAdet,
        "mesajyon": mesajyon,
        "donem": donem,
        "okulId": okulId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
