import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/delete.dart';
import '../../helper/web_api/is_status.dart';

Future<bool?> ogrenciSil({
  required String id,
  required String token,
}) async {
  http.Response? response = await deleteData(
      adres: ServiceAdres().ogrenciSil,
      body: {"_id": id, "durum": "false"},
      headers: {"x-access-token": token});

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    debugPrint(response.body);
    hataMesaj = message["message"];
    debugPrint("ogrenciSil message:" + message["message"]);
    return null;
  }

  return true;
}
