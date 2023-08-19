import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../../model/web_api/veli/veli_yemek_not.dart';
import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelVeliYemekNot?> veliYemekNotGetir({
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
      adres: ServiceAdres().veliYemekNotGetOgrenci,
      body: body,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    // debugPrint("veliYemekNotGetir:" + message["message"]);
    return null;
  } else {
    try {
      return ModelVeliYemekNot.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelVeliYemekNot:modelde sorun oluştu!";
    }
    return null;
  }
}
