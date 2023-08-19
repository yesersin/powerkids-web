import 'package:com.powerkidsx/screen/ogretmen/anasayfa/gunluk_akis/gunluk_akis_giris.dart';
import 'package:flutter/material.dart';

import '../../../component/custom/button.dart';
import '../../../const/renk.dart';
import '../../../static/cogretmen.dart';
import '../../../static/geri_boolean.dart';
import '../../yonetici/anasayfa/gunluk_akis/gunluk_akis_yukle.dart';

class FotografVideoEkle extends StatelessWidget {
  const FotografVideoEkle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        fotografVideoYukle(),
      ],
    );
  }

  Widget fotografVideoYukle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Buton().mavi(
            click: () {
              geri = false;
              co.syfGunlukAkis.value = true;
              co.syfFotografYukle.value = true;
              co.anasayfaSayfalari.clear();
              co.anasayfaSayfalari.add(OgretmenGunlukAkisGiris(c: co));
              co.anasayfaSayfalari.add(GunlukAkisYukleEkran(c: co, fotograf: true));
              co.ogretmenSayfalar[0] = co.anasayfaSayfalari.last;
            },
            text: "Fotoğraf Yükle",
            renk: Renk.turuncu,
            image: "asset/image/upload_yukle.svg",
            svg: true),
        SizedBox(height: 10),
        Buton().mavi(
            click: () {
              geri = false;
              co.syfGunlukAkis.value = true;
              co.syfFotografYukle.value = true;
              co.anasayfaSayfalari.clear();
              co.anasayfaSayfalari.add(OgretmenGunlukAkisGiris(c: co));
              co.anasayfaSayfalari.add(GunlukAkisYukleEkran(c: co, fotograf: false));
              co.ogretmenSayfalar[0] = co.anasayfaSayfalari.last;
            },
            text: "Video Yükle",
            // renk: Renk.turuncu,
            image: "asset/image/upload_yukle.svg",
            svg: true)
      ],
    );
  }
}
