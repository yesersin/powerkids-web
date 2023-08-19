// To parse this JSON data, do
//
//     final ModelDogumGunuKullanici = ModelDogumGunuKullaniciFromJson(jsonString);

import 'dart:convert';

ModelDogumGunuKullanici ModelDogumGunuKullaniciFromJson(String str) =>
    ModelDogumGunuKullanici.fromJson(json.decode(str));

String ModelDogumGunuKullaniciToJson(ModelDogumGunuKullanici data) =>
    json.encode(data.toJson());

class ModelDogumGunuKullanici {
  ModelDogumGunuKullanici({
    required this.success,
    required this.data,
  });

  int success;
  List<DogumGunuKullanici> data;

  factory ModelDogumGunuKullanici.fromJson(Map<String, dynamic> json) =>
      ModelDogumGunuKullanici(
        success: json["success"],
        data: List<DogumGunuKullanici>.from(
            json["data"].map((x) => DogumGunuKullanici.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DogumGunuKullanici {
  DogumGunuKullanici({
    required this.id,
    required this.adSoyad,
    required this.dogumTarihi,
    required this.yetki,
  });

  String id;
  String adSoyad;
  DateTime dogumTarihi;
  Yetki yetki;

  factory DogumGunuKullanici.fromJson(Map<String, dynamic> json) => DogumGunuKullanici(
        id: json["_id"],
        adSoyad: json["adSoyad"],
        dogumTarihi: DateTime.parse(json["dogumTarihi"]),
        yetki: Yetki.fromJson(json["yetki"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adSoyad": adSoyad,
        "dogumTarihi": dogumTarihi.toIso8601String(),
        "yetki": yetki.toJson(),
      };
}

class Yetki {
  Yetki({
    required this.veli,
    required this.ogretmen,
    required this.admin,
    required this.brans,
  });

  bool veli;
  bool ogretmen;
  bool admin;
  bool brans;

  factory Yetki.fromJson(Map<String, dynamic> json) => Yetki(
        veli: json["veli"],
        ogretmen: json["ogretmen"],
        admin: json["admin"],
        brans: json["brans"],
      );

  Map<String, dynamic> toJson() => {
        "veli": veli,
        "ogretmen": ogretmen,
        "admin": admin,
        "brans": brans,
      };
}
