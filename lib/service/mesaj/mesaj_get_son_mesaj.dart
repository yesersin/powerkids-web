import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/mesaj/mesaj_veli_ogretmen.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajVeliOgretmen?> mesajGetSonMesaj({
  required String mesajEsleId,
  required String gid,
  required String yetki,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"mesajEsleId": mesajEsleId});
  body.addAll({"gid": gid}); //gönderen id
  body.addAll({"yetki": yetki});

  http.Response? response = await postData(
      adres: ServiceAdres().mesajGetSonMesaj, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("mesajGetSonMesaj:" + message["message"]);
    return null;
  } else {
    try {
      return ModelMesajVeliOgretmen.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelMesajVeliOgretmen:modelde sorun oluştu!";
    }
    return null;
  }
}
