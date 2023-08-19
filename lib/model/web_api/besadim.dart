// To parse this JSON data, do
//
//     final modelBesadim = modelBesadimFromJson(jsonString);

import 'dart:convert';

ModelBesadim modelBesadimFromJson(String str) => ModelBesadim.fromJson(json.decode(str));

String modelBesadimToJson(ModelBesadim data) => json.encode(data.toJson());

class ModelBesadim {
  ModelBesadim({
    required this.success,
    required this.data,
  });

  int success;
  List<Datum> data;

  factory ModelBesadim.fromJson(Map<String, dynamic> json) => ModelBesadim(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.andUrl,
    required this.aciklama,
    required this.logo,
    required this.telefon,
    required this.andV,
    required this.iosV,
    required this.iosUrl,
    required this.mail,
    required this.androidUrl,
    required this.diller,
    required this.dil,
  });

  String id;
  String andUrl;
  String aciklama;
  String logo;
  String telefon;
  String andV;
  String iosV;
  String iosUrl;
  String mail;
  String androidUrl;
  List<String> diller;
  Dil dil;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        andUrl: json["andUrl"],
        aciklama: json["aciklama"],
        logo: json["logo"],
        telefon: json["telefon"],
        andV: json["andV"],
        iosV: json["iosV"],
        iosUrl: json["iosUrl"],
        mail: json["mail"],
        androidUrl: json["androidUrl"],
        diller: List<String>.from(json["diller"].map((x) => x)),
        dil: Dil.fromJson(json["dil"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "andUrl": andUrl,
        "aciklama": aciklama,
        "logo": logo,
        "telefon": telefon,
        "andV": andV,
        "iosV": iosV,
        "iosUrl": iosUrl,
        "mail": mail,
        "androidUrl": androidUrl,
        "diller": List<dynamic>.from(diller.map((x) => x)),
        "dil": dil.toJson(),
      };
}

class Dil {
  Dil({
    required this.eng,
    required this.tur,
    required this.arb,
    required this.rus,
  });

  Map<String, String> eng;
  Map<String, String> tur;
  Map<String, String> arb;
  Map<String, String> rus;

  factory Dil.fromJson(Map<String, dynamic> json) => Dil(
        eng: Map.from(json["ENG"]).map((k, v) => MapEntry<String, String>(k, v)),
        tur: Map.from(json["TUR"]).map((k, v) => MapEntry<String, String>(k, v)),
        arb: Map.from(json["ARB"]).map((k, v) => MapEntry<String, String>(k, v)),
        rus: Map.from(json["RUS"]).map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "ENG": Map.from(eng).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "TUR": Map.from(tur).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ARB": Map.from(arb).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "RUS": Map.from(rus).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
