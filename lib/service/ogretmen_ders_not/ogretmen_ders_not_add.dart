import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/ogretmen_ders_not_update_cevap.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/baseurl.dart';
import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgretmenDersNotUpdateCevap?> addOgretmenDersNot({
  required String gun,
  required String ay,
  required String yil,
  required String notText,
  required String baslik,
  required String dil,
  required String okulId,
  required String sinifId,
  required String ders,
  required String ogretmenAdSoyad,
  required String dersId,
  required String ogretmenId,
  required PlatformFile? file,
  required String token,
}) async {
  try {
    final postUri = Uri.parse(baseUrl + ServiceAdres().ogretmenDersNotAdd);
    var request = http.MultipartRequest("POST", postUri);
    request.fields.addAll({
      "gun": gun,
      "ay": ay,
      "yil": yil,
      "not": notText,
      "baslik": baslik,
      "dil": dil,
      "okulId": okulId,
      "sinifId": sinifId,
      "ders": ders,
      "ogretmenAdSoyad": ogretmenAdSoyad,
      "dersId": dersId,
      "ogretmenId": ogretmenId,
    });
    request.headers.addAll({"x-access-token": token});

    if (file != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'file', // API'de beklenen dosya alan adını buraya girin
          file.bytes!,
          filename: file.name,
        ),
      );
    }

    // İsteği gönderin ve cevabı alın
    http.StreamedResponse response = await request.send();
    final responseString = await response.stream.bytesToString();

    var data = jsonDecode(responseString);
    debugPrint("success:" + data["success"].toString());
    debugPrint("-----------");

    if (data["success"].toString() != "1") {
      //hata olmuş
      hataMesaj = data["message"];
      debugPrint("addDuyuru:" + data["message"]);
      return null;
    } else {
      try {
        return ModelOgretmenDersNotUpdateCevap.fromJson(data);
      } catch (e) {
        hataMesaj = "ModelOgretmenDersNotUpdateCevap:modelde sorun oluştu!";
      }
      return null;
    }
  } catch (e) {
    hataMesaj = "AddOgretmenDersNot:" + e.toString();
    debugPrint("addOgretmenDersNot big mistake:" + e.toString());
    return null;
  }
}
