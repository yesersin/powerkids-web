import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/ders_program.dart';
import '../../static/hata_mesaj.dart';

Future<ModelDersProgram?> dersProgramOkulGetir({
  required String okulId,
  required String sinifId,
  required String tip,
  required String ay,
  required String gun,
  required String yil,
  required String donem,
  required String token,
  required bool brans,
  required String ogretmenId,
}) async {
  Map<String, String> body = {};

  body.addAll({"ay": ay});

  body.addAll({"yil": yil});
  body.addAll({"donem": donem});
  // debugPrint("gun:$gun ay:$ay");
  //branş öğretmeni için
  http.Response? response;
  if (brans) {
    //branş öğretmeni
    body.addAll({"ogretmenId": ogretmenId});
    debugPrint("branş öğretmeni getiriliyor");
    response = await postData(
        adres: ServiceAdres().bransOgretmenDersProgramGetir,
        body: body,
        headers: {"x-access-token": token});
  } else {
    debugPrint("okul ders programı getiriliyor");
    body.addAll({"okulId": okulId});
    body.addAll({"sinifId": sinifId});
    body.addAll({"gun": gun});
    body.addAll({"tip": tip});
    response = await postData(
        adres: ServiceAdres().dersProgramOkulGetir,
        body: body,
        headers: {"x-access-token": token});
  }

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("dersProgramOkulGetir:" + message["message"]);
    return null;
  } else {
    // debugPrint("data geldi1:");

    try {
      return ModelDersProgram.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelDersProgram:modelde sorun oluştu!";
    }
    return null;
  }
}
