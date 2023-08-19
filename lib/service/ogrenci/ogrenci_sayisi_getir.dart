import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_sayisi.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciSayisi?> ogrenciSayisiGetir({
  required String okulId,
  required String token,
}) async {
  Map<String, String> body = {
    "okulId": okulId,
  };
  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciSayisiGetir,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ModelOgrenciSayisi:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciSayisi.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciSayisi:modelde sorun oluştu!";
    }
    return null;
  }
}
