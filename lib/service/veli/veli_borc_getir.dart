import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/veli/veli_borc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelVeliBorc?> veliBorcGetir({
  required String ogrenciId,
  required String okulId,
  required String veliId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"ogrenciId": ogrenciId});
  body.addAll({"okulId": okulId});
  body.addAll({"veliId": veliId});

  http.Response? response = await postData(
      adres: ServiceAdres().veliBorcGetir, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veliBorcGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelVeliBorc.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelVeliBorc:modelde sorun oluştu!";
    }
    return null;
  }
}
