import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_get_anything.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciGetAnyThing?> ogrenciGetAnything({
  required String okulId,
  required String token,
}) async {
  debugPrint("okulId id:" + okulId);
  Map<String, String> body = {
    "okulId": okulId,
  };

  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciGetAnything,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    debugPrint("hata oldu");
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciGetAnything:" + message["message"]);
    return null;
  } else {
    debugPrint("geldi");
    try {
      ModelOgrenciGetAnyThing a = ModelOgrenciGetAnyThing.fromJson(jsonDecode(response!.body));
    } catch (e) {
      debugPrint(e.toString());
    }

    try {
      return ModelOgrenciGetAnyThing.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciGetAnyThing:modelde sorun oluştu!";
    }
    return null;
  }
}
