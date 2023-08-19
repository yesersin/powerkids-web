import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_durum.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOkulDurum?> getOkulDurum({required String okulId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulDurum,
      body: {"_id": okulId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getOkulDurum:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOkulDurum.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOkulDurum:modelde sorun oluştu!";
    }
    return null;
  }
}
