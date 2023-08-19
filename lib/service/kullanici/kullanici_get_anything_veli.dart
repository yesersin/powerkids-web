import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciAnythingVeli?> kullaniciGetAnythingVeliGetir({
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});

  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetAnything,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciGetAnythingVeliGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciAnythingVeli.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciAnythingVeli:modelde sorun oluştu!";
    }
    return null;
  }
}

Future<ModelKullaniciAnythingVeli?> kullaniciGetAnythingVeliGetirX({
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"veli": "true"});
  body.addAll({"brans": "false"});
  body.addAll({"ogretmen": "false"});

  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetAnything,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciGetAnythingVeliGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciAnythingVeli.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciAnythingVeli:modelde sorun oluştu!";
    }
    return null;
  }
}
