import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post_raw_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/yonetici_etkinlik_akis.dart';
import '../../static/hata_mesaj.dart';

Future<ModelYoneticiEtkinlikAkis?> yoneticiEtkinlikAkisGetir({
  required String okulId,
  required String sinifId,
  required String token,
  required DateTime tarih,
}) async {
  Map<String, dynamic> body = {
    "sinifId": sinifId,
    "okulId": okulId,
    "yil": tarih.year,
    "ay": tarih.month,
    "gun": tarih.day,
  };
  http.Response? response = await postRawData(
      adres: ServiceAdres().yoneticiEtkinlikAkisGetir,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("yoneticiEtkinlikAkisGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelYoneticiEtkinlikAkis.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelYoneticiEtkinlikAkis:modelde sorun oluştu!";
    }
    return null;
  }
}
