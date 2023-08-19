import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/ogretmen_ders_not_update_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgretmenDersNotUpdateCevap?> ogretmenDersNotUpdate(
    {required String id,
    required bool durum,
    required String notText,
    required String token}) async {
  Map<String, String> body = {};
  body.addAll({"_id": id});
  body.addAll({"durum": durum.toString()});
  body.addAll({"not": notText});
  http.Response? response = await patchData(
      adres: ServiceAdres().ogretmenDersNotUpdate,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogretmenDersNotUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgretmenDersNotUpdateCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgretmenDersNotUpdateCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
