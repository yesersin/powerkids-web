import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/mesaj/mesaj_esle_veli_ogretmen.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajEsleVeliOgretmen?> mesajEsleVeliOgretmenEkle({
  required String veliId,
  required String ogretmenId,
  required String okulId,
  required String yetki,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"veliId": veliId});
  body.addAll({"okulId": okulId});
  body.addAll({"yetki": yetki});
  body.addAll({"ogretmenId": ogretmenId});

  http.Response? response = await postData(
      adres: ServiceAdres().mesajEsleVeliOgretmenEkle,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("mesajEsleVeliOgretmenEkle:" + message["message"]);
    return null;
  } else {
    debugPrint(response!.body);
    try {
      return ModelMesajEsleVeliOgretmen.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelMesajEsleVeliOgretmen:modelde sorun oluştu!";
    }
    return null;
  }
}
