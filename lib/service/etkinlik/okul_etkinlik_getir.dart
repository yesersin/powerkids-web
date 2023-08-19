import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/etkinlik.dart';
import '../../static/hata_mesaj.dart';

Future<ModelEtkinlik?> getOkulEtkinlik(
    {required String okulId, required String dil, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulEtkinlikGetir,
      body: {"okulId": okulId, "dil": dil},
      headers: {"x-access-token": token});

  if (!isStatus(response)) {
    //hata olmuş

    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getOkulEtkinlik:" + message["message"]);
    return null;
  } else {
    try {
      return ModelEtkinlik.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelDersProgram:modelde sorun oluştu!";
    }
    return null;
  }
}
