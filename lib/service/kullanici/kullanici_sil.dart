import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/delete.dart';
import '../../helper/web_api/is_status.dart';
import '../../model/web_api/kullanici/kullanici_getir.dart';

Future<bool?> kullaniciSil({
  required String id,
  required String token,
}) async {
  http.Response? response = await deleteData(
      adres: ServiceAdres().kullaniciSil,
      body: {"_id": id, "durum": "false"},
      headers: {"x-access-token": token});
  late ModelKullaniciGetir kullanici;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciSil:" + message["message"]);
    return null;
  }

  return true;
}
