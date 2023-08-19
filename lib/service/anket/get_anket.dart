import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/anket/anket.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';

Future<ModelAnket?> getAnket(
    {required String okulId, required String dil, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().anketGet,
      body: {"okulId": okulId, "dil": dil},
      headers: {"x-access-token": token});
  late ModelAnket anket;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getAnket:" + message["message"]);
    return null;
  }
  try {
    //anket bilgisini getir
    anket = ModelAnket.fromJson(jsonDecode(response!.body));
  } catch (e) {
    debugPrint("getAnket modelinde sorun oluştu!" + e.toString());
    hataMesaj = "getAnket modelinde sorun oluştu!" + e.toString();
    return null;
  }
  return anket;
}
