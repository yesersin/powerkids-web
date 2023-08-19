import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../const/web_api/service_adres.dart';
import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../static/hata_mesaj.dart';

Future<bool> setKullaniciSmsSifre({required String telefon}) async {
  http.Response? response =
      await postData(adres: ServiceAdres().setKullaniciSmsSifre, body: {"telefon": telefon});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("setKullaniciSmsSifre:" + message["message"]);
    return false;
  } else {
    return true;
  }
}
