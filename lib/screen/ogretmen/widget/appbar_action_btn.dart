import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../anasayfa/duyuru/duyuru_ekle_btn.dart';
import 'bildirim_btn.dart';
import 'gunluk_akis_ekle_btn.dart';

Widget appbarActionBtn({required COgretmen c}) {
  if (c.sayfaSecilenIndex.value == 0) {
    //anasayfa
    if (c.syfHakkinda.value) {
      return SizedBox();
    }
    if (c.syfYemekAyrinti.value) {
      return SizedBox();
    }
    if (c.syfYemekMenu.value) {
      return SizedBox();
    }
    if (c.syfDersProgram.value) {
      return SizedBox();
    }
    if (c.syfEtkinlikler.value) {
      return SizedBox();
    }
    if (c.syfFotografYukle.value) {
      return SizedBox();
    }
    if (c.syfGunlukAkis.value) {
      return gunlukAkisEkleBtn(c: c);
    }
    if (c.syfDuyuru.value) {
      return duyuruEkleBtn(c: c);
    }
  }

  if (c.bildirimSayfasi.value == false) {
    return bildirimSayfasiBtn(c: c);
  }
  return SizedBox();
}
