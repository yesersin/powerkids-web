import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/veli2/widget/veli_ilac_ekle_btn.dart';
import 'package:flutter/material.dart';

import 'bildirim_btn.dart';

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
  }
  // if (c.veliYoklamaSayfaEkleBtn.value == true) {
  //   return veliYoklamaEkleBtn(c: c);
  // }
  if (c.veliIlacSayfaEkleBtn.value == true) {
    return veliIlacEkleBtn(c: c);
  }
  if (c.bildirimSayfasi.value == false) {
    return bildirimSayfasiBtn(c: c);
  }

  return SizedBox();
}
