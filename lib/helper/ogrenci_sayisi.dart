import 'package:flutter/cupertino.dart';

import '../model/web_api/ogrenci/ogrenci_sayisi.dart';
import '../service/ogrenci/ogrenci_sayisi_getir.dart';
import '../static/cprogram.dart';

Future<ModelOgrenciSayisi?> ogrenciSayisiYukle() async {
  ModelOgrenciSayisi? sayi = await ogrenciSayisiGetir(
    token: cp.kullanici.token,
    okulId: cp.okul!.data.id,
  );
  debugPrint("öğrenci sayısı yükleniyor:" + sayi!.toString());
  return sayi;
}
