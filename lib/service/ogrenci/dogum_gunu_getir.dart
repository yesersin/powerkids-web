import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/ogrenci/dogum_gunu_olanlari_getir.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelDogumGunu?> getDogumGunu(
    {required String okulId, required String sinifId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciDogumGunu,
      body: {"okulId": okulId, "sinifId": sinifId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getDuyurular:" + message["message"]);
    return null;
  } else {
    try {
      return ModelDogumGunu.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelDogumGunu:modelde sorun oluştu!";
    }
    return null;
  }
}
