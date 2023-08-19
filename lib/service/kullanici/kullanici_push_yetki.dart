import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/patch_raw_data_encoded.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<String?> kullaniciPushYetki({
  required Map<String, String> body,
  required String token,
}) async {
  http.Response? response = await patchRawDataEncoded(
      adres: ServiceAdres().kullaniciPushYetki,
      body: body,
      headers: {
        "x-access-token": token,
        "Content-Type": "application/x-www-form-urlencoded",
      });
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciPushYetki:" + message["message"]);
    return null;
  } else {
    return "başarılı";
  }
}
