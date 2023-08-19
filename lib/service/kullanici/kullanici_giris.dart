import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/toast.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/kullanici/kullanici_giris.dart';

Future<ModelKullanici?> kullaniciGiris(
    {required String telefon, required String sifre}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGiris, body: {"telefon": telefon, "sifre": sifre});
  late ModelKullanici kullanici;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    toast(msg: message["message"]);
    debugPrint("kullaniciGiris:" + message["message"]);
    return null;
  }
  try {
    //kullanıcı bilgisini getir
    kullanici = ModelKullanici.fromJson(jsonDecode(response!.body));
  } catch (e) {
    debugPrint("Kullanıcı modelinde sorun oluştu!" + e.toString());
    hataMesaj = "Kullanıcı modelinde sorun oluştu!" + e.toString();
    return null;
  }
  return kullanici;
}
