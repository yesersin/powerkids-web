import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../static/hata_mesaj.dart';

Future<bool?> updateOgrenciEtkinlikAkis({
  required String id,
  required Map<String, String> body,
  required String token,
}) async {
  body.addAll({"_id": id});
  http.Response? response = await patchData(
      adres: ServiceAdres().ogrenciEtkinlikAkisUpdate,
      body: body,
      headers: {"x-access-token": token});
  debugPrint("gelen cevap:" + response!.body);
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("updateOgrenciEtkinlikAkis:" + message["message"]);
    return null;
  } else {
    try {
      return true;
      // return ModelOgrenciEtkinlikUpCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciEtkinlikUpCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
