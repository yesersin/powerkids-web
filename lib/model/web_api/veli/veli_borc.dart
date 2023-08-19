// To parse this JSON data, do
//
//     final modelVeliBorc = modelVeliBorcFromJson(jsonString);

import 'dart:convert';

ModelVeliBorc modelVeliBorcFromJson(String str) => ModelVeliBorc.fromJson(json.decode(str));

String modelVeliBorcToJson(ModelVeliBorc data) => json.encode(data.toJson());

class ModelVeliBorc {
  ModelVeliBorc({
    required this.success,
    required this.data,
  });

  int success;
  List<VeliBorcData> data;

  factory ModelVeliBorc.fromJson(Map<String, dynamic> json) => ModelVeliBorc(
        success: json["success"],
        data: List<VeliBorcData>.from(json["data"].map((x) => VeliBorcData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VeliBorcData {
  VeliBorcData({
    required this.id,
    required this.okulId,
    required this.ogrenciId,
    required this.veliId,
    required this.borcId,
    required this.vadeTarihi,
    required this.taksitNo,
    required this.taksitTutari,
    required this.odemeTipi,
    required this.odenenTutar,
    required this.url,
    required this.dil,
    required this.durum,
    required this.odemeTarihi,
    required this.createdAt,
    required this.updatedAt,
    required this.link,
    required this.toplamBorc,
    required this.aciklama,
    required this.hizmetAdi,
  });

  String id;
  String okulId;
  String ogrenciId;
  String veliId;
  String borcId;
  DateTime vadeTarihi;
  int taksitNo;
  int taksitTutari;
  int odemeTipi;
  int odenenTutar;
  String url;
  String dil;
  bool durum;
  DateTime odemeTarihi;
  DateTime createdAt;
  DateTime updatedAt;
  bool link;
  int toplamBorc;
  String aciklama;
  String hizmetAdi;

  factory VeliBorcData.fromJson(Map<String, dynamic> json) => VeliBorcData(
        id: json["_id"],
        okulId: json["okulId"],
        ogrenciId: json["ogrenciId"],
        veliId: json["veliId"],
        borcId: json["borcId"],
        vadeTarihi: DateTime.parse(json["vadeTarihi"]),
        taksitNo: json["taksitNo"],
        taksitTutari: json["taksitTutari"],
        odemeTipi: json["odemeTipi"],
        odenenTutar: json["odenenTutar"],
        url: json["url"],
        dil: json["dil"],
        durum: json["durum"],
        odemeTarihi: DateTime.parse(json["odemeTarihi"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        link: json["link"],
        toplamBorc: json["toplamBorc"],
        aciklama: json["aciklama"],
        hizmetAdi: json["hizmetAdi"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "okulId": okulId,
        "ogrenciId": ogrenciId,
        "veliId": veliId,
        "borcId": borcId,
        "vadeTarihi": vadeTarihi.toIso8601String(),
        "taksitNo": taksitNo,
        "taksitTutari": taksitTutari,
        "odemeTipi": odemeTipi,
        "odenenTutar": odenenTutar,
        "url": url,
        "dil": dil,
        "durum": durum,
        "odemeTarihi": odemeTarihi.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "link": link,
        "toplamBorc": toplamBorc,
        "aciklama": aciklama,
        "hizmetAdi": hizmetAdi,
      };
}
