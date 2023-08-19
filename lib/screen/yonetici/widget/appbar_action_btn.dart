import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/duyuru/yeni_duyuru_ekle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/ogretmen/widget/yeni_ogretmen_ekle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/veli/widget/yeni_veli_ekle_btn.dart';
import 'package:flutter/material.dart';

Widget appbarActionBtn({required COgretmen c}) {
  if (c.sayfaSecilenIndex.value == 1) {
    //ekle sayfası
    if (c.yoneticiVeliEkle.value) {
      return yeniVeliEkleBtn();
    }
    if (c.yoneticiOgretmenEkle.value) {
      return yeniOgretmenEkleBtn();
    }
    if (c.yoneticiDuyuruEkle.value) {
      return yoneticiDuyuruEkleBtn();
    }
  }
  return SizedBox();
}
