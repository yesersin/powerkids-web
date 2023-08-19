import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_veli_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajVeliList?> mesajSinifVeliListGetir({
  required String okulId,
  required String sinifId,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"sinifId": sinifId});

  http.Response? response = await postData(
      adres: ServiceAdres().mesajSinifVeliListGetir,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("mesajSinifVeliListGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelMesajVeliList.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelMesajVeliList:modelde sorun oluştu!";
    }
    return null;
  }
}
