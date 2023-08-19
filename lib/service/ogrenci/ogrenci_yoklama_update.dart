import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/ogrenci/ogrenci_yoklama_up_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciYoklamaUpCevap?> updateOgrenciYoklama({
  required String id,
  required String yoklamaDurum,
  required Map<String, String> body,
  required String token,
}) async {
  body.addAll({"_id": id});
  body.addAll({"yoklamaDurum": yoklamaDurum});
  http.Response? response = await patchData(
      adres: ServiceAdres().ogrenciYoklamaUpdate,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("updateOgrenciYoklama:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciYoklamaUpCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciYoklamaUpCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
