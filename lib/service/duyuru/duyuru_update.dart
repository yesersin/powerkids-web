import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_gelen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../static/hata_mesaj.dart';

Future<ModelDuyuru?> updateDuyuru(
    {required String id, required Map<String, String> body, required String token}) async {
  body.addAll({"_id": id});
  http.Response? response = await patchData(
      adres: ServiceAdres().duyuruUpdate, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("updateDuyuru:" + message["message"]);
    return null;
  } else {
    try {
      return ModelDuyuru.fromJson(jsonDecode(response!.body)["data"]);
    } catch (e) {
      hataMesaj = "ModelDersProgram:modelde sorun oluştu!";
    }
    return null;
  }
}
