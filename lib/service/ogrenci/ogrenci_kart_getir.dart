import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/ogrenci/ogrenci_karti.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciKarti?> ogrenciKartGetir({
  required String ogrenciId,
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"ogrenciId": ogrenciId});
  body.addAll({"okulId": okulId});

  debugPrint("ogrenciKartGetir:Okul:" + okulId);
  debugPrint("ogrenciKartGetir:ogrenciId:" + ogrenciId);
  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciKartGetir, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciKartGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciKarti.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciKarti:modelde sorun oluştu!" + e.toString();
      debugPrint("ModelOgrenciKarti:modelde sorun oluştu!" + e.toString());
    }
    return null;
  }
}
