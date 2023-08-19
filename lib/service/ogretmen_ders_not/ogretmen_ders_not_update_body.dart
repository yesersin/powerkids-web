import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../static/hata_mesaj.dart';

Future<String?> ogretmenDersNotUpdateBody(
    {required Map<String, String> body, required String token}) async {
  http.Response? response = await patchData(
      adres: ServiceAdres().ogretmenDersNotUpdate,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogretmenDersNotUpdateBody:" + message["message"]);
    return null;
  } else {
    var message = jsonDecode(response!.body);
    return message["message"];
  }
}
