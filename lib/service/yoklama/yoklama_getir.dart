import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/yoklama/yoklama.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelYoklama?> yoklamaGetir({
  required String okulId,
  required String sinifId,
  required String dil,
  required String tip,
  required String ay,
  required String gun,
  required String yil,
  required String token,
  String? ogretmenId,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"sinifId": sinifId});
  body.addAll({"dil": dil});
  body.addAll({"tip": tip});
  body.addAll({"ay": ay});
  body.addAll({"gun": gun});
  body.addAll({"yil": yil});
  debugPrint(body.toString());
  if (ogretmenId != null) {
    body.addAll({"ogretmenId": ogretmenId});
  }

  http.Response? response = await postData(
      adres: ServiceAdres().yoklamaGetSinif, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("yoklamaGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelYoklama.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelYoklama:modelde sorun oluştu!";
    }
    return null;
  }
}
