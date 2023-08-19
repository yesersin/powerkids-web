import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/okul/okul.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOkul?> getOkul({required String okulId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().okulGetir,
      body: {"_id": okulId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    debugPrint("getOkul:" + message["message"]);
    hataMesaj = message["message"];
    return null;
  } else {
    try {
      return ModelOkul.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOkul:modelde sorun oluştu!";
    }
    return null;
  }
}
