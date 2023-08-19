import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/bildirim/bildirim_add_cevap.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';

Future<ModelBildirimAddCevap?> bildirimAdd({
  required String okulId,
  required String alanId,
  required String gonderenId,
  required String alanNotificationId,
  required String mesaj,
  required String tip,
  String? etkinlikId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"alanId": alanId});
  body.addAll({"gonderenId": gonderenId});
  body.addAll({"alanNotificationId": alanNotificationId});
  body.addAll({"mesaj": mesaj});
  body.addAll({"tip": tip});
  if (tip == "1") {
    body.addAll({"etkinlikId": etkinlikId!});
  }

  http.Response? response = await postData(
      adres: ServiceAdres().bildirimAdd, body: body, headers: {"x-access-token": token});
  late ModelBildirimAddCevap cevap;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("bildirimAdd:" + message["message"]);
    return null;
  }
  try {
    cevap = ModelBildirimAddCevap.fromJson(jsonDecode(response!.body));
    debugPrint("bildirim eklendi");
  } catch (e) {
    debugPrint("ModelBildirimAddCevap modelinde sorun oluştu!" + e.toString());
    hataMesaj = "bildirimAdd modelinde sorun oluştu!" + e.toString();
    return null;
  }
  return cevap;
}
