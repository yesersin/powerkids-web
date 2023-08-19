import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<ModelSinifOgrencileri?> getSinifOgrencileri(
    {required String okulId, required String sinifId, required String token}) async {
  http.Response? response = await postData(
      adres: ServiceAdres().sinifOgrencileri,
      body: {"okulId": okulId, "sinifId": sinifId},
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("getSinifOgrencileri:" + message["message"]);
    return null;
  } else {
    try {
      return ModelSinifOgrencileri.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelSinifOgrencileri:modelde sorun oluştu!";
    }
    return null;
  }
}
