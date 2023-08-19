import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/veli/veli_yemek_not_update_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelVeliYemekNotUpdateCevap?> veliYemekNotUpdate(
    {required Map<String, String> body, required String token}) async {
  http.Response? response = await patchData(
      adres: ServiceAdres().veliYemekNotUpdate,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veliYemekNotUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return ModelVeliYemekNotUpdateCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelVeliYemekNotUpdateCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
