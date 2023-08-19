import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/kullanici/kullanici_update.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciUpdate?> kullaniciUpdate(
    {required Map<String, String> body, required String token}) async {
  http.Response? response = await patchData(
    adres: ServiceAdres().kullaniciUpdate,
    body: body,
    headers: {"x-access-token": token},
  );
  debugPrint(body.toString());
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciUpdate.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciUpdate:modelde sorun oluştu!";
    }
    return null;
  }
}
