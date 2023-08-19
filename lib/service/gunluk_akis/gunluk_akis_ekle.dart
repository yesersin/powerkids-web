import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/web_api/post_raw_data.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis_ekle_sonuc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelGunlukAkisEkleSonuc?> gunlukAkisEkle({
  required String okulId,
  required String sinifId,
  required String donem,
  required String token,
  required String baslik,
  required String ekleyenId,
  required String aciklama,
  required List<String> url,
  required String onaylamaIzni,
  required String tip,
  required DateTime tarihSaat,
}) async {
  // {
  //   "okulId":"62e2785d426829de30fb2137",
  // "sinifId":"62e2785d426829de30fb2137",
  // "donem":"2022-2023",
  // "baslik":"test222555",
  // "ekleyenId":"62e2785d426829de30fb2137",
  // "aciklama":"deneme acıklama",
  // "url":[
  // "https://powerkidsapp.com/aaa/resim.jpg",
  // "https://powerkidsapp.com/aaa/resim2.jpg"],
  // "onaylamaIzni":false,
  // "tip":1 //tip:1 fotoğraf, tip:2 video.
  // }

  Map<String, dynamic> body = {
    "okulId": okulId,
    "sinifId": sinifId,
    "donem": donem,
    "ekleyenId": ekleyenId,
    "baslik": baslik,
    "aciklama": aciklama,
    "url": url,
    "onaylamaIzni": onaylamaIzni,
    "tarihSaat": tarihSaat.toIso8601String(),
    "tip": tip
  };
  debugPrint("günlük akış gönderilen data:" + body.toString());
  http.Response? response = await postRawData(
      adres: ServiceAdres().gunlukAkisEkle, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("gunlukAkisEkle:" + message["message"]);
    return null;
  } else {
    try {
      return ModelGunlukAkisEkleSonuc.fromJson(jsonDecode(response!.body));
    } catch (e) {
      hataMesaj = "ModelGunlukAkisEkleSonuc:modelde sorun oluştu!";
    }
    return null;
  }
}
