import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch_raw_data_encoded.dart';
import '../../model/web_api/kullanici/kullanici_update.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciUpdate?> kullaniciUpdateYonetici(
    {required Map<String, dynamic> body, required String token}) async {
  // body = {"_id": "6421cb2424bd60ccb3c057fa", "sinifId[0]": "6421cb2424bd60ccb3c057fa"};
  debugPrint(body.toString());
  http.Response? response = await patchRawDataEncoded(
    adres: ServiceAdres().kullaniciUpdate,
    body: body,
    headers: {
      "x-access-token": token,
      "Content-Type": "application/x-www-form-urlencoded",
    },
  );
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciUpdateYonetici:" + message["message"]);
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
