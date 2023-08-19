import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/ogretmen_ders_not.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgretmenDersNot?> ogretmenDersNotGetirDersId({
  required String ay,
  required String gun,
  required String yil,
  required String sinifId,
  required String dersId,
  required String token,
}) async {
  Map<String, String> body = {};

  body.addAll({"ay": ay});
  body.addAll({"gun": gun});
  body.addAll({"yil": yil});
  body.addAll({"sinifId": sinifId});
  body.addAll({"dersId": dersId});

  http.Response? response = await postData(
      adres: ServiceAdres().ogretmenDersNotGetirDersId,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogretmenDersNotGetir:" + message["message"]);
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
