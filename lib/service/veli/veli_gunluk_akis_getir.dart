import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/helper/web_api/post_raw_data.dart';
import 'package:com.powerkidsx/model/veli_gunluk_akis.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../helper/web_api/is_status.dart';
import '../../helper/web_api/post.dart';
import '../../model/web_api/ogrenci/ogrenci_etklnlik_gecmis.dart';
import '../../model/web_api/ogrenci/ogrenci_yoklama_gecmis.dart';
import '../../model/web_api/ogretmen_ders_not.dart';
import '../../static/cprogram.dart';
import '../../static/hata_mesaj.dart';
import '../ogretmen_ders_not/ogretmen_ders_not_getir_sinif_id.dart';

Future<List<ModelVeliGunlukAkis>> veliGunlukAkisGetir({
  required String okulId,
  required String ogrenciId,
  required String sinifId,
  required String token,
  required DateTime tarih,
  required String yetki,
  required String dil,
}) async {
  List<ModelVeliGunlukAkis> list = [];

  //günlük akış
  Map<String, dynamic> body = {
    "sinifId": sinifId,
    "okulId": okulId,
    "yil": tarih.year,
    "ay": tarih.month,
    "gun": tarih.day,
    "yetki": yetki,
  };
  http.Response? response = await postRawData(
      adres: ServiceAdres().gunlukAkisGetir, body: body, headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veligunlukAkisGetir:" + message["message"]);
    // return null;
  } else {
    try {
      ModelGunlukAkis data = ModelGunlukAkis.fromJson(jsonDecode(response!.body));
      for (var element in data.data) {
        list.add(
            ModelVeliGunlukAkis(data: element, gunlukakis: true, tarih: element.tarihSaat));
      }
    } catch (e) {
      toast(msg: "ModelVeliGünlükAkış hata!");
    }
  }
  //günlük akış

  //yoklama
  Map<String, String>? body2 = {
    "ogrenciId": ogrenciId,
    "okulId": okulId,
    "yil": tarih.year.toString(),
    "ay": tarih.month.toString(),
    "gun": tarih.day.toString(),
    "dil": dil,
  };
  response = await postData(
      adres: ServiceAdres().ogrenciYoklamaAkisGetir,
      body: body2,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veliogrenciYoklamaGecmisiGetir:" + message["message"]);
    // return null;
  } else {
    try {
      ModelOgrenciYoklamaGecmis data =
          ModelOgrenciYoklamaGecmis.fromJson(jsonDecode(response!.body));
      for (var element in data.data) {
        list.add(ModelVeliGunlukAkis(data: element, yoklama: true, tarih: element.zaman));
      }
    } catch (e) {
      toast(msg: "ModelVeliYoklama hata!");
    }
  }
  //yoklama

  //etkinlik akış
  body2 = {
    "ogrenciId": ogrenciId,
    "okulId": okulId,
    "yil": tarih.year.toString(),
    "ay": tarih.month.toString(),
    "gun": tarih.day.toString(),
    "dil": dil,
  };
  response = await postData(
      adres: ServiceAdres().ogrenciEtkinlikAkisGetir,
      body: body2,
      headers: {"x-access-token": token});
  if (!isStatus(response)) {
    //hata olmuş
    var message = jsonDecode(response!.body);
    hataMesaj = message["message"];
    debugPrint("veliogrenciEtkinlikGecmisiGetir:" + message["message"]);
    // return null;
  } else {
    try {
      ModelOgrenciEtkinlikGecmis data =
          ModelOgrenciEtkinlikGecmis.fromJson(jsonDecode(response!.body));
      for (var element in data.data) {
        list.add(ModelVeliGunlukAkis(data: element, etkinlikakis: true, tarih: element.zaman));
      }
    } catch (e) {
      toast(msg: "ModelVeliÖğrenciEtkinlik hata!");
    }
  }
  //etkinlik akış

  //ders ödev-not

  ModelOgretmenDersNot? not = await ogretmenDersNotGetirSinifId(
    sinifId: cp.sinif.id,
    yil: tarih.year.toString(),
    ay: tarih.month.toString(),
    gun: tarih.day.toString(),
    token: cp.kullanici.token,
  );
  if (not == null) {
    debugPrint("öğretmen ders not:" + hataMesaj);
  } else {
    for (var element in not.data) {
      list.add(ModelVeliGunlukAkis(data: element, dersnot: true, tarih: element.createdAt));
    }
  }
  //ders ödev-not

  list.sort((a, b) => a.tarih.compareTo(b.tarih));
  return list;
}
