import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<bool> veliYemekNotAdd({
  required String gun,
  required String ay,
  required String yil,
  required String not,
  required String ogun,
  required String dil,
  required String okulId,
  required String ogrenciId,
  required String veliId,
  required String veliAdSoyad,
  required String ogrenciAdSoyad,
  required String sinifId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"gun": gun});
  body.addAll({"ay": ay});
  body.addAll({"yil": yil});
  body.addAll({"not": not});
  body.addAll({"ogun": ogun});
  body.addAll({"dil": dil});
  body.addAll({"okulId": okulId});
  body.addAll({"ogrenciId": ogrenciId});
  body.addAll({"veliId": veliId});
  body.addAll({"veliAdSoyad": veliAdSoyad});
  body.addAll({"ogrenciAdSoyad": ogrenciAdSoyad});
  body.addAll({"sinifId": sinifId});

  http.Response? response = await postData(
      adres: ServiceAdres().veliYemekNotAdd, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veliBorcGetir:" + message["message"]);
    return false;
  } else {
    return true;
  }
}
