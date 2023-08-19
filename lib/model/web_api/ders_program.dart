// To parse this JSON data, do
//
//     final modelDersProgram = modelDersProgramFromJson(jsonString);

import 'dart:convert';

ModelDersProgram modelDersProgramFromJson(String str) =>
    ModelDersProgram.fromJson(json.decode(str));

String modelDersProgramToJson(ModelDersProgram data) => json.encode(data.toJson());

class ModelDersProgram {
  ModelDersProgram({
    required this.success,
    required this.data,
  });

  int success;
  List<DersProgram> data;

  factory ModelDersProgram.fromJson(Map<String, dynamic> json) => ModelDersProgram(
        success: json["success"],
        data: List<DersProgram>.from(json["data"].map((x) => DersProgram.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DersProgram {
  DersProgram({
    required this.id,
    required this.okulId,
    required this.tip,
    required this.yil,
    required this.donem,
    required this.ay,
    required this.gun,
    required this.baslik,
    required this.icerik,
    required this.ogretmenId,
    required this.ogretmenAdSoyad,
    required this.sinifAdi,
  });

  String id;
  String okulId;
  String tip;
  int yil;
  String donem;
  int ay;
  int gun;
  String baslik;
  String icerik;
  String ogretmenId;
  List<String> ogretmenAdSoyad;
  List<String> sinifAdi;

  factory DersProgram.fromJson(Map<String, dynamic> json) => DersProgram(
        id: json["_id"],
        okulId: json["okulId"],
        tip: json["tip"],
        yil: json["yil"],
        donem: json["donem"],
        ay: json["ay"],
        gun: json["gun"],
        baslik: json["baslik"],
        icerik: json["icerik"],
        ogretmenId: json["ogretmenId"],
        ogretmenAdSoyad: List<String>.from(json["ogretmenAdSoyad"].map((x) => x)),
        sinifAdi: List<String>.from(json["sinifAdi"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "tip": tip,
        "yil": yil,
        "donem": donem,
        "ay": ay,
        "gun": gun,
        "baslik": baslik,
        "icerik": icerik,
        "ogretmenId": ogretmenId,
        "ogretmenAdSoyad": List<dynamic>.from(ogretmenAdSoyad.map((x) => x)),
        "sinifAdi": List<dynamic>.from(sinifAdi.map((x) => x)),
      };
}
