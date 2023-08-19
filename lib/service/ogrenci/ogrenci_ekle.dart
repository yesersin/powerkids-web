import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_ekle_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciEkleCevap?> ogrenciEkle({
  required Map<String, String> body,
  required String token,
}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciEkle, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciEkle:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciEkleCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciEkleCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
