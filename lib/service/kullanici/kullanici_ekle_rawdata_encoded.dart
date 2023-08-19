import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch_raw_data_encoded.dart';
import '../../model/web_api/kullanici/kullanici_ekle_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciEkleCevap?> kullaniciEkleEncoded({
  required String token,
  required Map<String, dynamic> body,
}) async {
  http.Response? response =
      await patchRawDataEncoded(adres: ServiceAdres().kullaniciEkle, body: body, headers: {
    "x-access-token": token,
    "Content-Type": "application/x-www-form-urlencoded",
  });
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("kullaniciEkle:" + message["message"]);
    return null;
  } else {
    try {
      return ModelKullaniciEkleCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelKullaniciEkleCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
