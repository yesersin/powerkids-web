import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../static/hata_mesaj.dart';

Future<String?> kullaniciPushOgrenci({
  required Map<String, String> body,
  required String token,
}) async {
  http.Response? response = await patchData(
      adres: ServiceAdres().kullaniciPushOgrenci,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciPushOgrenci:" + message["message"]);
    return null;
  } else {
    return "başarılı";
  }
}
