import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_update_cevap.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/baseurl.dart';
import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelOgrenciUpdateCevap?> ogrenciProfilResimUpdate({
  required String okulId,
  required String id,
  required PlatformFile? file,
  required String token,
}) async {
  try {
    final postUri = Uri.parse(baseUrl + ServiceAdres().ogrenciUpProfilResim);
    var request = http.MultipartRequest("POST", postUri);
    request.fields.addAll({
      "okulId": okulId,
      "_id": id,
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
        return ModelOgrenciUpdateCevap.fromJson(data);
      } catch (e) {
        hataMesaj = "ModelOgrenciUpdateCevap:modelde sorun oluştu!";
      }
      return null;
    }
  } catch (e) {
    debugPrint("ogrenciProfilResimUpdate big mistake:" + e.toString());
    hataMesaj = ("ogrenciProfilResimUpdate big mistake:" + e.toString());
    return null;
  }
}
