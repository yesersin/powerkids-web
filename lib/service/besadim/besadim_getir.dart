import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/get.dart';
import '../../helper/web_api/is_status.dart';
import '../../model/web_api/besadim.dart';
import '../../static/hata_mesaj.dart';

Future<ModelBesadim?> getBesadim() async {
  http.Response? data;
  try {
    data = await getData(adres: ServiceAdres().besadim);
    if (!isStatus(data)) {
      //hata olmuş
      var message = jsonDecode(data!.body);

      hataMesaj = message["message"];
      debugPrint("getBesadim:" + message["message"]);
      return null;
    }
  } catch (e) {
    hataMesaj = "Beşadım Serivisine sorun oluştu!" + e.toString();
    debugPrint("Beşadım Serivisine sorun oluştu!" + e.toString());
    return null;
  }
  try {
    return ModelBesadim.fromJson(jsonDecode(data!.body));
  } catch (e) {
    hataMesaj = "besadim:modelde sorun oluştu!";
    debugPrint("besadim:modelde sorun oluştu!");
  }
  return null;
}
