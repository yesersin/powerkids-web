import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/mesaj/mesaj_okunmayan_sayi.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajOkunmayanSayi?> mesajOkunmayanSayiGetir({
  required String gid,
  required String yetki,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"gid": gid}); //gönderen id
  body.addAll({"yetki": yetki});

  http.Response? response = await postData(
      adres: ServiceAdres().mesajOkunmayanSayi,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("mesajOkunmayanSayiGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelMesajOkunmayanSayi.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelMesajOkunmayanSayi:modelde sorun oluştu!";
    }
    return null;
  }
}
