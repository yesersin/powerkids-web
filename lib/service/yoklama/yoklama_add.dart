import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/yoklama/yoklama_add_cevap.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelYoklamaAddCevap?> yoklamaAdd({
  required String okulId,
  required String sinifId,
  required String yoklamaDurum,
  required String ogretmenAdi,
  required String ogrenciId,
  required String tip,
  required String ogretmenId,
  required String dil,
  required String token,
}) async {
  http.Response? response = await postData(adres: ServiceAdres().yoklamaAdd, body: {
    "okulId": okulId,
    "sinifId": sinifId,
    "yoklamaDurum": yoklamaDurum,
    "ogretmenAdi": ogretmenAdi,
    "ogrenciId": ogrenciId,
    "tip": tip,
    "ogretmenId": ogretmenId,
    "dil": dil,
  }, headers: {
    "x-access-token": token
  });
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("yoklamaAdd:" + message["message"]);
    return null;
  } else {
    debugPrint("yoklama eklendi:" + ogrenciId);

    try {
      return ModelYoklamaAddCevap.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelYoklamaAddCevap:modelde sorun oluştu!";
    }
    return null;
  }
}
