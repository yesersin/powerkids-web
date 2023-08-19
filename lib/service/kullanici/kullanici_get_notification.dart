import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/kullanici/kullanici_notification.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciNotification?> kullaniciGetNotification({
  required String kullaniciId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"kullaniciId": kullaniciId});

  http.Response? response = await postData(
      adres: ServiceAdres().kullaniciGetNotification,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciGetNotification:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciNotification.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciNotification:modelde sorun oluştu!" + e.toString();
    }
    return null;
  }
}
