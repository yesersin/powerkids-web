import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/mesaj/mesaj_add_cevap.dart';
import '../../static/hata_mesaj.dart';

Future<MesajAddData?> mesajUpdate({
  required String id,
  required String token,
  required Map<String, String> body,
}) async {
  Map<String, String> bodyAll = body;

  bodyAll.addAll({"_id": id}); //gönderen id

  http.Response? response = await patchData(
    adres: ServiceAdres().mesajUpdate,
    body: bodyAll,
    headers: {"x-access-token": token},
  );
  debugPrint(response!.body);
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];

    debugPrint("mesajUpdate:" + message["message"]);
    return null;
  } else {
    try {
      return MesajAddData.fromJson(jsonDecode(response.body)["data"]);
    } catch (e) {
      hataMesaj = "MesajAddData:modelde sorun oluştu!";
    }
    return null;
  }
}
