import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/sinif_ogretmenleri.dart';
import '../../static/hata_mesaj.dart';

Future<ModelSinifOgretmenleri?> sinifOgretmenleriGetir({
  required String sinifId,
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"sinifId": sinifId});
  body.addAll({"okulId": okulId});
  body.addAll({"veli": "false"});

  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetAnything,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("sinifOgretmenleriGetir:" + message["message"]);
    return null;
  } else {
    debugPrint("sinifOgretmenleriGetir:");
    try {
      return ModelSinifOgretmenleri.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelSinifOgretmenleri:modelde sorun oluştu!";
    }
    return null;
  }
}
