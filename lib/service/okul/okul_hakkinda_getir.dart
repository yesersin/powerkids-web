import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_hakkinda.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOkulHakkinda?> getOkulHakkinda(
    {required String okulId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulHakkindaGetir,
      body: {"_id": okulId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getOkulHakkinda:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOkulHakkinda.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOkulHakkinda:modelde sorun oluştu!";
    }
    return null;
  }
}
