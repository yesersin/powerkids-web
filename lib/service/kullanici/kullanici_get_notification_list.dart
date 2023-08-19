import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_notification.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';

Future<ModelKullaniciNotification?> getKullaniciNotificationList(
    {required String okulId,
    required String sinifId,
    required String token,
    bool? ogretmen}) async {
  Map<String, String> body = {"okulId": okulId, "sinifId": sinifId};
  if (ogretmen != null && ogretmen == true) {
    body.addAll({"ogretmen": "true"});
  }
  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciNotificationId,
      body: body,
      headers: {"x-access-token": token});
  late ModelKullaniciNotification list;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getKullaniciNotificationList:" + message["message"]);
    return null;
  }
  try {
    //notification bilgisini getir
    debugPrint(response!.body);
    list = ModelKullaniciNotification.fromJson(jsonDecode(response!.body));
  } catch (e) {
    debugPrint("ModelKullaniciNotification modelinde sorun oluştu!" + e.toString());
    hataMesaj = "ModelKullaniciNotification modelinde sorun oluştu!" + e.toString();
    return null;
  }
  return list;
}
