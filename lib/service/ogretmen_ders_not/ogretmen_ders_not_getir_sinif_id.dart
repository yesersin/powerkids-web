import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/ogretmen_ders_not.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgretmenDersNot?> ogretmenDersNotGetirSinifId({
  required String ay,
  required String gun,
  required String yil,
  required String sinifId,
  required String token,
}) async {
  Map<String, String> body = {};

  body.addAll({"ay": ay});
  body.addAll({"gun": gun});
  body.addAll({"yil": yil});
  body.addAll({"sinifId": sinifId});

  http.Response? response = await postData(
      adres: ServiceAdres().ogretmenDersNotGetirSinifId,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogretmenDersNotGetirSinifId:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgretmenDersNot.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgretmenDersNot:modelde sorun oluştu!";
    }
    return null;
  }
}
