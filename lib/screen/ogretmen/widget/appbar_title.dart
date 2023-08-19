import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/widget/sinif_sec_btn.dart';
import 'package:flutter/material.dart';

Widget appbarTitle({required COgretmen c}) {
  if (c.sayfaSecilenIndex.value == 0) {
    if (c.syfHakkinda.value) {
      return Text("Hakkımızda");
    } else if (c.syfYemekAyrinti.value) {
      return Text("Sabah Kahvaltısı");
    } else if (c.syfDuyuru.value) {
      return Text("Duyurular");
    } else if (c.syfYemekMenu.value) {
      return Text("Yemek Menüsü");
    } else if (c.syfDersProgram.value) {
      return Text("Ders Programı");
    } else if (c.syfEtkinlikler.value) {
      return Text("Etkinlikler");
    } else if (c.bildirimSayfasi.value) {
      return Text("Bildirimler");
    } else if (c.syfGunlukAkis.value || c.syfFotografYukle.value) {
      return Text("Günlük Akış");
    }
  }

  return sinifSecBtn();
}
