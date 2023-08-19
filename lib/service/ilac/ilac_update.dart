import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/ilac/ilac_update.dart';
import '../../static/hata_mesaj.dart';

Future<ModelIlacUpdate?> ilacUpdate(
    {required Map<String, String> body, required String token}) async {
  http.Response? response = await patchData(
      adres: ServiceAdres().ilacUpdate, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ilacUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return ModelIlacUpdate.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelIlacUpdate:modelde sorun oluştu!";
    }
    return null;
  }
}
