import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_ilac.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciIlac?> ogrenciIlacGetir({
  required String sinifId,
  required String ogrenciId,
  required String token,
  required DateTime tarih,
  required String dil,
}) async {
  debugPrint("öğrenci id:" + ogrenciId);
  Map<String, String> body = {
    "ogrenciId": ogrenciId,
    "sinifId": sinifId,
    "yil": tarih.year.toString(),
    "ay": tarih.month.toString(),
    "gun": tarih.day.toString(),
    "dil": dil,
  };

  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciIlacGetir, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciIlacGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciIlac.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciIlac:modelde sorun oluştu!";
    }
    return null;
  }
}
