import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/okul/okul_siniflari.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOkulSiniflari?> getSiniflar(
    {required String okulId, required String donem, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulSiniflari,
      body: {"okulId": okulId, "donem": donem},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getSiniflar:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOkulSiniflari.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOkulSiniflari:modelde sorun oluştu!";
    }
    return null;
  }
}
