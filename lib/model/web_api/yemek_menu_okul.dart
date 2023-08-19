// To parse this JSON data, do
//
//     final modelYemekMenuOkul = modelYemekMenuOkulFromJson(jsonString);

import 'dart:convert';

ModelYemekMenuOkul modelYemekMenuOkulFromJson(String str) =>
    ModelYemekMenuOkul.fromJson(json.decode(str));

String modelYemekMenuOkulToJson(ModelYemekMenuOkul data) => json.encode(data.toJson());

class ModelYemekMenuOkul {
  ModelYemekMenuOkul({
    required this.success,
    required this.data,
  });

  int success;
  List<YemekOgun> data;

  factory ModelYemekMenuOkul.fromJson(Map<String, dynamic> json) => ModelYemekMenuOkul(
        success: json["success"],
        data: List<YemekOgun>.from(json["data"].map((x) => YemekOgun.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class YemekOgun {
  YemekOgun({
    required this.id,
    required this.okulId,
    required this.yil,
    required this.ay,
    required this.gun,
    required this.saat,
    required this.ogun,
    required this.dil,
    required this.yemekler,
    required this.yemek,
    required this.durum,
    required this.kalori,
  });

  String id;
  String okulId;
  int yil;
  int ay;
  int gun;
  String saat;
  int ogun;
  String dil;
  List<String> yemekler;
  String yemek;
  bool durum;
  int kalori;

  factory YemekOgun.fromJson(Map<String, dynamic> json) => YemekOgun(
        id: json["_id"],
        okulId: json["okulId"],
        yil: json["yil"],
        ay: json["ay"],
        gun: json["gun"],
        saat: json["saat"],
        ogun: json["ogun"],
        dil: json["dil"],
        yemekler: List<String>.from(json["yemekler"].map((x) => x)),
        yemek: json["yemek"],
        durum: json["durum"],
        kalori: json["kalori"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "yil": yil,
        "ay": ay,
        "gun": gun,
        "saat": saat,
        "ogun": ogun,
        "dil": dil,
        "yemekler": List<dynamic>.from(yemekler.map((x) => x)),
        "yemek": yemek,
        "durum": durum,
        "kalori": kalori,
      };
}
