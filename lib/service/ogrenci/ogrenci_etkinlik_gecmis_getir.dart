import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_etklnlik_gecmis.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciEtkinlikGecmis?> ogrenciEtkinlikGecmisiGetir({
  required String okulId,
  required String ogrenciId,
  required String token,
  required DateTime tarih,
  required String dil,
}) async {
  debugPrint("öğrenci id:" + ogrenciId);
  Map<String, String> body = {
    "ogrenciId": ogrenciId,
    "okulId": okulId,
    "yil": tarih.year.toString(),
    "ay": tarih.month.toString(),
    "gun": tarih.day.toString(),
    "dil": dil,
  };
  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciEtkinlikAkisGetir,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciEtkinlikGecmisiGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciEtkinlikGecmis.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciEtkinlikGecmis:modelde sorun oluştu!";
    }
    return null;
  }
}
