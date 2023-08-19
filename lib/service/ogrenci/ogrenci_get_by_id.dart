import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../model/web_api/ogrenci/ogrenci_get.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciGet?> ogrenciGetir({
  required String id,
  required String token,
}) async {
  debugPrint("öğrenci id:" + id);
  Map<String, String> body = {
    "_id": id,
  };

  http.Response? response = await postData(
      adres: ServiceAdres().ogrenciGetById, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOgrenciGet.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOgrenciGet:modelde sorun oluştu!";
    }
    return null;
  }
}
