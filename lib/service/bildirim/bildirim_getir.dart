import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/bildirim/bildirim.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelBildirim?> getBildirim(
    {required String okulId, required String alanId, required String token}) async {
  debugPrint("bildirim soruluyor");
  // debugPrint("alan:" + alanId);
  // debugPrint("okul:" + okulId);
  http.Response? response = await postData(
      adres: ServiceAdres().bildirimGet,
      body: {"okulId": okulId, "alanId": alanId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    debugPrint("bildirim gelmedi:");
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getBildirim:" + message["message"]);
    return null;
  } else {
    try {
      return ModelBildirim.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "getBildirim:modelde sorun oluştu!";
    }
    return null;
  }
}
