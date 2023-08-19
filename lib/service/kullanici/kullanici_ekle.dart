import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post_raw_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/kullanici/kullanici_ekle_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelKullaniciEkleCevap?> kullaniciEkle({
  required String token,
  required Map<String, dynamic> body,
}) async {
  http.Response? response = await postRawData(
      adres: ServiceAdres().kullaniciEkle, body: body, headers: {"x-access-token": token});
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
