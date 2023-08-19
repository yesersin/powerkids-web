import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/etkinlik_akis_add_cevap.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelEtkinlikAkisAddCevap?> etkinlikAkisAdd({
  required String okulId,
  required String sinifId,
  required String etkinlikId,
  required String ogrenciId,
  required String etkinlikAdi,
  required String ogretmenAdi,
  required String tercih,
  required String dil,
  required String tip,
  required String token,
}) async {
  http.Response? response = await postData(adres: ServiceAdres().etkinlikAkisAdd, body: {
    "okulId": okulId,
    "sinifId": sinifId,
    "etkinlikId": etkinlikId,
    "ogrenciId": ogrenciId,
    "etkinlikAdi": etkinlikAdi,
    "ogretmenAdi": ogretmenAdi,
    "tercih": tercih,
    "dil": dil,
    "tip": tip,
  }, headers: {
    "x-access-token": token
  });
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("etkinlikAkisAdd:" + message["message"]);
    return null;
  } else {
    debugPrint("etkinlikAkisAdd:etkinlik eklendi");
    try {
      return ModelEtkinlikAkisAddCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelEtkinlikAkisAddCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
