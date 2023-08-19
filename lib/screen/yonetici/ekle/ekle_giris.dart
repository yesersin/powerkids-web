import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/veli/veli1_giris.dart';
import 'package:flutter/material.dart';

import '../../../component/custom/button.dart';
import '../../../service/duyuru/duyuru_getir.dart';
import '../../../static/cogretmen.dart';
import '../../../static/cprogram.dart';
import '../../../static/geri_boolean.dart';
import 'duyuru/duyuru1_giris.dart';
import 'ogrenci/ogrenci1_giris.dart';
import 'ogretmen/ogretmen1_giris.dart';

class YoneticiEkleGiris extends StatefulWidget {
  const YoneticiEkleGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiEkleGiris> createState() => _YoneticiEkleGirisState();
}

class _YoneticiEkleGirisState extends State<YoneticiEkleGiris> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Buton().mavi(
            click: () {
              geri = false; //geri buton kontrolü
              co.yoneticiVeliGuncelle.value = true;
              co.yoneticiVeliEkle.value = true;
              co.yoneticiOgretmenEkle.value = false;
              co.yoneticiOgrenciEkle.value = false;
              co.yoneticiDuyuruEkle.value = false;
              co.yoneticiEkleSayfalari.add(YoneticiVeliEkleGiris());
              co.yoneticiSayfalar[1] = YoneticiVeliEkleGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Veli İşlem",
            renk: Renk.turuncu,
          ),
          SizedBox(width: 0, height: 20),
          Buton().mavi(
            click: () {
              geri = false; //geri buton kontrolü
              co.yoneticiVeliGuncelle.value = false;
              co.yoneticiVeliEkle.value = false;
              co.yoneticiOgretmenEkle.value = false;
              co.yoneticiOgrenciEkle.value = true;
              co.yoneticiOgrenciGuncelle.value = true;
              co.yoneticiDuyuruEkle.value = false;
              co.yoneticiEkleSayfalari.add(YoneticiOgrenciEkleGiris());
              co.yoneticiSayfalar[1] = YoneticiOgrenciEkleGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Öğrenci İşlem",
            renk: Renk.kirmizi,
          ),
          SizedBox(width: 0, height: 20),
          Buton().mavi(
            click: () {
              geri = false; //geri buton kontrolü
              co.yoneticiVeliGuncelle.value = false;
              co.yoneticiVeliEkle.value = false;
              co.yoneticiOgretmenEkle.value = true;
              co.yoneticiOgretmenGuncelle.value = true;
              co.yoneticiOgrenciEkle.value = false;
              co.yoneticiDuyuruEkle.value = false;
              co.yoneticiEkleSayfalari.add(YoneticiOgretmenEkleGiris());
              co.yoneticiSayfalar[1] = YoneticiOgretmenEkleGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Öğretmen İşlem",
            renk: Renk.maviAcik,
          ),
          SizedBox(width: 0, height: 20),
          Buton().mavi(
            click: () {
              co.duyuruList.clear();
              duyuruGetir = getDuyurular(
                token: cp.kullanici.token,
                okulId: cp.okul!.data.id,
                userId: cp.kullanici.data.id,
                sinifId: cp.sinif.id,
              );
              geri = false; //geri buton kontrolü
              co.yoneticiVeliGuncelle.value = false;
              co.yoneticiVeliEkle.value = false;
              co.yoneticiOgretmenEkle.value = false;
              co.yoneticiOgrenciEkle.value = false;
              co.yoneticiDuyuruEkle.value = true;
              co.yoneticiDuyuruGuncelle.value = true;
              co.yoneticiEkleSayfalari.add(YoneticiDuyuruEkleGiris());
              co.yoneticiSayfalar[1] = YoneticiDuyuruEkleGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Duyuru İşlem",
            renk: Renk.yesil,
          ),
        ],
      ),
    );
  }
}
