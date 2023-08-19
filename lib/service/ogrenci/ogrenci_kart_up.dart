import 'dart:convert';

import 'package:com.powerkidsx/helper/web_api/patch_raw_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_kart_up_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciKartUpCevap?> ogrenciKartUp({
  required String kartId,
  required String okulId,
  required String ogrenciId,
  required String token,
  required Map<String, dynamic> body,
}) async {
  body.addAll({"_id": kartId}); //kart id
  body.addAll({"okulId": okulId});
  body.addAll({"ogrenciId": ogrenciId});

  http.Response? response = await patchRawData(
    adres: ServiceAdres().ogrenciKartUp,
    body: body,
    headers: {"x-access-token": token, "content-type": "application/json"},
    // headers: {"x-access-token": token},
  );
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciKartUp:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciKartUpCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciKartUpCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
