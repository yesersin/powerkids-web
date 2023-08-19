// To parse this JSON data, do
//
//     final modelDogumGunu = modelDogumGunuFromJson(jsonString);

import 'dart:convert';

ModelDogumGunu modelDogumGunuFromJson(String str) => ModelDogumGunu.fromJson(json.decode(str));

String modelDogumGunuToJson(ModelDogumGunu data) => json.encode(data.toJson());

class ModelDogumGunu {
  ModelDogumGunu({
    required this.success,
    required this.data,
  });

  int success;
  List<DogumGunuOgrencisi> data;

  factory ModelDogumGunu.fromJson(Map<String, dynamic> json) => ModelDogumGunu(
        success: json["success"],
        data: List<DogumGunuOgrencisi>.from(
            json["data"].map((x) => DogumGunuOgrencisi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DogumGunuOgrencisi {
  DogumGunuOgrencisi({
    required this.id,
    required this.adSoyad,
    required this.dogumTarihi,
  });

  String id;
  String adSoyad;
  DateTime dogumTarihi;

  factory DogumGunuOgrencisi.fromJson(Map<String, dynamic> json) => DogumGunuOgrencisi(
        id: json["_id"],
        adSoyad: json["adSoyad"],
        dogumTarihi: DateTime.parse(json["dogumTarihi"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "adSoyad": adSoyad,
        "dogumTarihi": dogumTarihi.toIso8601String(),
      };
}
