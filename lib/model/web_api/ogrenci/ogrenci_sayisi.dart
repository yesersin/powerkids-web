// To parse this JSON data, do
//
//     final modelOgrenciSayisi = modelOgrenciSayisiFromJson(jsonString);

import 'dart:convert';

ModelOgrenciSayisi modelOgrenciSayisiFromJson(String str) =>
    ModelOgrenciSayisi.fromJson(json.decode(str));

String modelOgrenciSayisiToJson(ModelOgrenciSayisi data) => json.encode(data.toJson());

class ModelOgrenciSayisi {
  ModelOgrenciSayisi({
    required this.success,
    required this.data,
  });

  int success;
  OgrenciSayisiData data;

  factory ModelOgrenciSayisi.fromJson(Map<String, dynamic> json) => ModelOgrenciSayisi(
        success: json["success"],
        data: OgrenciSayisiData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class OgrenciSayisiData {
  OgrenciSayisiData({
    required this.ogrenci,
    required this.okul,
    required this.fark,
  });

  int ogrenci;
  int okul;
  int fark;

  factory OgrenciSayisiData.fromJson(Map<String, dynamic> json) => OgrenciSayisiData(
        ogrenci: json["ogrenci"],
        okul: json["okul"],
        fark: json["fark"],
      );

  Map<String, dynamic> toJson() => {
        "ogrenci": ogrenci,
        "okul": okul,
        "fark": fark,
      };
}
