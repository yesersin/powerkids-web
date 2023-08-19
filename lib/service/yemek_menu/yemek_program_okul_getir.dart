import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/yemek_menu_okul.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelYemekMenuOkul?> yemekProgramOkulGetir({
  required String okulId,
  required String dil,
  required String ay,
  required String gun,
  required String yil,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": okulId});
  body.addAll({"dil": dil});
  body.addAll({"ay": ay});
  body.addAll({"gun": gun});
  body.addAll({"yil": yil});
  debugPrint(body.toString());
  http.Response? response = await postData(
      adres: ServiceAdres().yemekProgramOkul, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("yemekProgramOkulGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelYemekMenuOkul.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelYemekMenuOkul:modelde sorun oluştu!";
    }
    return null;
  }
}
