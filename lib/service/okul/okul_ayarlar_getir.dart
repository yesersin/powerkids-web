import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/okul/okul_ayarlar.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOkulAyarlar?> getOkulAyarlar(
    {required String okulId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulAyarlarGetir,
      body: {"okulId": okulId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getOkulAyarlar:A" + message.toString());
    return null;
  } else {
    try {
      var sonuc = ModelOkulAyarlar.fromJson(jsonDecode(response!.body));
      debugPrint("getOkulAyarlar:B " + sonuc.toString());
      return sonuc;
    } catch (e) {
      hataMesaj = "ModelOkulAyarlar:modelde sorun oluştu!";
      debugPrint("ModelOkulAyarlar: E " + e.toString());
    }
    return null;
  }
}
