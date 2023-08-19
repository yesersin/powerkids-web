import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/kullanici/kullanici_getir.dart';

Future<ModelKullaniciGetir?> kullaniciGetir({
  required String id,
  required String token,
}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetir,
      body: {"_id": id},
      headers: {"x-access-token": token});
  late ModelKullaniciGetir kullanici;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciGetir:" + message["message"]);
    return null;
  }
  try {
    //kullanıcı bilgisini getir
    kullanici = ModelKullaniciGetir.fromJson(jsonDecode(response!.body));
  } catch (e) {
    debugPrint("Kullanıcı modelinde sorun oluştu!" + e.toString());
    hataMesaj = "Kullanıcı modelinde sorun oluştu!" + e.toString();
    return null;
  }
  return kullanici;
}
