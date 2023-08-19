import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_ozel_beslenme.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOzelBeslenme?> ozelBeslenmeGetir({
  required String ogrenciId,
  required String ogun,
  required String ay,
  required String gun,
  required String yil,
  required String token,
}) async {
  Map<String, String> body = {};
  body.addAll({"ogrenciId": ogrenciId});
  body.addAll({"ogun": ogun});
  body.addAll({"ay": ay});
  body.addAll({"gun": gun});
  body.addAll({"yil": yil});

  http.Response? response = await postData(
      adres: ServiceAdres().ozelBeslenmeGetOgrenci,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    // debugPrint("ozelBeslenmeGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelOzelBeslenme.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelOzelBeslenme:modelde sorun oluştu!";
    }
    return null;
  }
}
