import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis_ekle_sonuc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../static/hata_mesaj.dart';

Future<ModelGunlukAkisEkleSonuc?> updateGunlukAkis(
    {required String id, required Map<String, String> body, required String token}) async {
  body.addAll({"_id": id});
  http.Response? response = await patchData(
      adres: ServiceAdres().gunlukAkisUpdate, body: body, headers: {"x-access-token": token});
  Map<String, dynamic> message = jsonDecode(response!.body);
  if (!isStatus(response)) {
    //eski kod var message = jsonDecode(response!.body); ama model hatası veriyordu. bu sekilde duzelttim.
    hataMesaj = message["message"];
    return null;
  } else {
    debugPrint(response!.body);
    try {
      return ModelGunlukAkisEkleSonuc.fromJson(jsonDecode(response!.body));
    } catch (e) {
      debugPrint("ModelGunlukAkisEkleSonuc:modelde sorun oluştu!" + e.toString());
    }
    return null;
  }
}

Future<String?> updateBegenGorulduGunlukAkis(
    {required String id, required Map<String, String> body, required String token}) async {
  try {
    body.addAll({"_id": id});
    http.Response? response = await patchData(
        adres: ServiceAdres().gunlukAkisUpdate,
        body: body,
        headers: {"x-access-token": token});
    Map<String, dynamic> message = jsonDecode(response!.body);
    debugPrint("günlük akış görüldü atılıyor.");

    if ((message["success"] == 0 || message["success"] == "0")) {
      return message["message"];
    } else {
      return message["data"];
    }
  } catch (e) {
    debugPrint("ModelGunlukAkisEkleSonuc:modelde sorun oluştumu!" + e.toString());
  }
}
