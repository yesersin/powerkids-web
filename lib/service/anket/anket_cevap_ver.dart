import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/model/web_api/anket/anket.dart';
import 'package:com.powerkidsx/model/web_api/anket/anket_cevap.dart';
import 'package:com.powerkidsx/screen/ogretmen/anket/model/model_anket_text_controller.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';

Future<ModelAnketCevap?> anketCevapVer(
    {required AnketData gelenAnket,
    required ModelAnketTextController anketController,
    required String token}) async {
  Map<String, String> body = {};
  body.addAll({"okulId": cp.okul!.data.id});
  body.addAll({"anketId": gelenAnket.id});
  body.addAll({"kullaniciId": cp.kullanici.data.id});
  if (anketController.c1.text != "") {
    body.addAll({"birCevap": anketController.c1.text});
  }
  if (anketController.c2.text != "") {
    body.addAll({"ikiCevap": anketController.c2.text});
  }
  if (anketController.c3.text != "") {
    body.addAll({"ucCevap": anketController.c3.text});
  }
  if (anketController.c4.text != "") {
    body.addAll({"dortCevap": anketController.c4.text});
  }
  int puan = 0;
  if (gelenAnket.puan) {
    puan = anketController.butonController.selectedIndex! + 1;
  }
  body.addAll({"puan": (puan).toString()});
  debugPrint("anket puanı:" + puan.toString());
  body.addAll({"dil": cp.dil});

  http.Response? response = await postData(
      adres: ServiceAdres().anketCevapVer, body: body, headers: {"x-access-token": token});

  late ModelAnketCevap anket;

  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("anketCevapVer:" + message["message"]);
    return null;
  }
  try {
    //anket bilgisini getir
    anket = ModelAnketCevap.fromJson(jsonDecode(response!.body));
  } catch (e) {
    debugPrint("Anket model sorun oluştu!" + e.toString());
    hataMesaj = "Anket model sorun oluştu!" + e.toString();
    return null;
  }
  return anket;
}
