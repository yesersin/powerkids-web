import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_sohbet_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajSohbetList?> mesajSinifSohbetListGetir({
  required String okulId,
  required String id,
  required String yetki,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"id": id});
  body.addAll({"yetki": yetki});
  debugPrint("id:" + id);
  http.Response? response = await postData(
      adres: ServiceAdres().mesajSinifSohbetListGetir,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("mesajSinifSohbetListGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelMesajSohbetList.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelMesajSohbetList:modelde sorun oluştu!";
    }
    return null;
  }
}
