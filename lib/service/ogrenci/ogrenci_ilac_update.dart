import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/ilac/ilac_update_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciIlacUpdateCevap?> ogrenciIlacUpdate(
    {required Map<String, String> body, required String token}) async {
  http.Response? response = await patchData(
    adres: ServiceAdres().ogrenciIlacUpdate,
    body: body,
    headers: {"x-access-token": token},
  );
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciIlacUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciIlacUpdateCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciIlacUpdateCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
