import 'dart:async';
import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/upload_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../const/web_api/baseurl.dart';
import '../../const/web_api/service_adres.dart';
import '../../static/hata_mesaj.dart';

Future<ModelUploadFile?> gunlukAkisUploadFoto({
  required String okulId,
  required String sinifId,
  required String ekleyenId,
  required String token,
  required String tip,
  required PlatformFile file,
}) async {
  try {
    final postUri = Uri.parse(baseUrl + ServiceAdres().gunlukAkisUploadFile);
    debugPrint("-----------");
    // Dosya verilerini ve diğer parametreleri içeren bir FormData oluşturun
    final request = http.MultipartRequest('POST', postUri);
    request.fields.addAll({
      "okulId": okulId,
      "ekleyenId": ekleyenId,
      "tip": tip,
      "sinifId": sinifId,
    });
    request.headers.addAll({"x-access-token": token});
    request.files.add(
      http.MultipartFile.fromBytes(
        'file', // API'de beklenen dosya alan adını buraya girin
        file.bytes!,
        filename: file.name,
      ),
    );

    // İsteği gönderin ve cevabı alın
    StreamedResponse response = await request.send();
    final responseString = await response.stream.bytesToString();

    var data = jsonDecode(responseString);
    debugPrint("success:" + data["success"].toString());
    debugPrint("-----------");

    if (data["success"].toString() != "1") {
      //işlem başarılı değilse
      //hata olmuş
      hataMesaj = data["message"];
      debugPrint("gunlukAkisUploadFile:" + data["message"]);
      return null;
    } else {
      return ModelUploadFile.fromJson(data);
    }
  } catch (e) {
    debugPrint("dosya upload big mistake:" + e.toString());
    return null;
  }
}
