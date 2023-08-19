import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/baseurl.dart';
import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../model/web_api/mesaj/mesaj_add_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<ModelMesajAddCevap?> mesajAdd({
  required String okulId,
  required String mesajEsleId,
  required String gid,
  required String adSoyad,
  required String yetki,
  required String mesaj,
  required String tip,
  required PlatformFile? file,
  required String token,
}) async {
  try {
    final postUri = Uri.parse(baseUrl + ServiceAdres().mesajAdd);
    var request = http.MultipartRequest("POST", postUri);
    request.fields.addAll({
      "okulId": okulId,
      "mesajEsleId": mesajEsleId,
      "gid": gid,
      "adSoyad": adSoyad,
      "yetki": yetki,
      "mesaj": mesaj,
      "tip": tip,
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
      return ModelMesajAddCevap.fromJson(data);
    }
  } catch (e) {
    debugPrint("mesajAdd big mistake:" + e.toString());
    hataMesaj = ("mesajAdd big mistake:" + e.toString());
    return null;
  }
}
