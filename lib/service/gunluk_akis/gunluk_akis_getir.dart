import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post_raw_data.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelGunlukAkis?> gunlukAkisGetir({
  required String okulId,
  required String sinifId,
  required String token,
  required DateTime tarih,
  required String yetki,
}) async {
  // {
  //   "sinifId":"62e2785d426829de30fb2137",
  // "okulId":"61f1b8937ecb8fd678c83681",
  // "yil":2022,
  // "ay":10,
  // "gun":30,
  // "yetki":"admin"
  // }

  Map<String, dynamic> body = {
    "sinifId": sinifId,
    "okulId": okulId,
    "yil": tarih.year,
    "ay": tarih.month,
    "gun": tarih.day,
    "yetki": yetki,
  };
  http.Response? response = await postRawData(
      adres: ServiceAdres().gunlukAkisGetir, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("gunlukAkisGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelGunlukAkis.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelGunlukAkis:modelde sorun oluştu!";
    }
    return null;
  }
}
