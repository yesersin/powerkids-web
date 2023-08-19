import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/geri_boolean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/custom/button.dart';
import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/renk.dart';
import '../anasayfa/anasayfa_giris.dart';
import '../anasayfa/gunluk_akis/gunluk_akis_yukle.dart';

Widget gunlukAkisEkleBtn({required COgretmen c}) {
  return IconButton(
      onPressed: () {
        Pencere().ac(
            content: fotografVideoYukle(c: c),
            context: Get.context!,
            baslik: "Seçim yapınız",
            yukseklik: 150);
      },
      icon: Icon(Icons.add));
}

Widget fotografVideoYukle({required COgretmen c, Function? sayfaDegis}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Buton().mavi(
          click: () {
            geri = false;
            c.syfGunlukAkis.value = true;
            c.syfFotografYukle.value = true;
            c.anasayfaSayfalari.clear();
            c.anasayfaSayfalari.add(YoneticiAnasayfaGiris());
            c.anasayfaSayfalari.add(GunlukAkisYukleEkran(c: c, fotograf: true));
            c.ogretmenSayfalar[0] = c.anasayfaSayfalari.last;
            if (sayfaDegis != null) sayfaDegis();
            Get.back();
          },
          text: "Fotoğraf Yükle",
          renk: Renk.turuncu,
          image: "asset/image/upload_yukle.svg",
          svg: true),
      SizedBox(height: 10),
      Buton().mavi(
          click: () {
            geri = false;
            c.syfGunlukAkis.value = true;
            c.syfFotografYukle.value = true;
            c.anasayfaSayfalari.clear();
            c.anasayfaSayfalari.add(YoneticiAnasayfaGiris());
            c.anasayfaSayfalari.add(GunlukAkisYukleEkran(c: c, fotograf: false));
            c.ogretmenSayfalar[0] = c.anasayfaSayfalari.last;
            if (sayfaDegis != null) sayfaDegis();
            Get.back();
          },
          text: "Video Yükle",
          // renk: Renk.turuncu,
          image: "asset/image/upload_yukle.svg",
          svg: true)
    ],
  );
}
