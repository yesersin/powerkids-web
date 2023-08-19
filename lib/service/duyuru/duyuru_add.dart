import 'dart:convert';

import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_add_cevap.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/baseurl.dart';
import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../static/hata_mesaj.dart';

Future<ModelDuyuruAddCevap?> addDuyuru({
  required String okulId,
  required String sinifId,
  required String ekleyenId,
  required String ekleyenAd,
  required String baslik,
  required String aciklama,
  required String dil,
  required String oncelik,
  required String ebeveyn,
  required String onayDurum,
  required PlatformFile? file,
  required String token,
}) async {
  try {
    final postUri = Uri.parse(baseUrl + ServiceAdres().duyuruAdd);
    var request = http.MultipartRequest("POST", postUri);
    request.fields.addAll({
      "okulId": okulId,
      "sinifId": sinifId,
      "ekleyenId": ekleyenId,
      "ekleyenAd": ekleyenAd,
      "baslik": baslik,
      "aciklama": aciklama,
      "dil": dil,
      "oncelik": oncelik,
      "ebeveyn": ebeveyn,
      "onayDurum": onayDurum,
      // "tip": UploadFileTip.belge,
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
      return ModelDuyuruAddCevap.fromJson(data);
    }
  } catch (e) {
    debugPrint("addDuyuru big mistake:" + e.toString());
    hataMesaj = "addDuyuru big mistake:" + e.toString();
    return null;
  }
}
