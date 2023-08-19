import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/kullanici/kullanici_anything.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciAnyThing?> kullaniciGetAnythingGetir({
  required String ogrenciId,
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"ogrenciId": ogrenciId});
  body.addAll({"okulId": okulId});

  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetAnything,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciGetAnythingGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciAnyThing.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciAnyThing:modelde sorun oluştu!" + e.toString();
    }
    return null;
  }
}
