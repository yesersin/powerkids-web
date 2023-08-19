import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/yonetici/rapor/yoklama/yoklama1_giris.dart';
import 'package:flutter/material.dart';

import '../../../component/custom/button.dart';
import '../../../static/cogretmen.dart';
import '../../../static/geri_boolean.dart';
import 'etkinlik/etkinlik1_giris.dart';

class YoneticiRaporGiris extends StatefulWidget {
  const YoneticiRaporGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiRaporGiris> createState() => _YoneticiRaporGirisState();
}

class _YoneticiRaporGirisState extends State<YoneticiRaporGiris> {
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
              co.yoneticiVeliEkle.value = true;
              co.yoneticiOgretmenEkle.value = false;
              co.yoneticiOgrenciEkle.value = false;
              co.yoneticiDuyuruEkle.value = false;
              co.yoneticiRaporSayfalari.add(YoneticiRaporEtkinliGiris());
              co.yoneticiSayfalar[3] = YoneticiRaporEtkinliGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Etkinlik",
            renk: Renk.turuncu,
          ),
          SizedBox(width: 0, height: 20),
          Buton().mavi(
            click: () {
              geri = false; //geri buton kontrolü
              co.yoneticiVeliEkle.value = false;
              co.yoneticiOgretmenEkle.value = false;
              co.yoneticiOgrenciEkle.value = true;
              co.yoneticiDuyuruEkle.value = false;
              co.yoneticiRaporSayfalari.add(YoneticiRaporYoklamaGiris());
              co.yoneticiSayfalar[3] = YoneticiRaporYoklamaGiris();
            },
            image: "asset/image/kullanici_ekle.svg",
            svg: true,
            text: "Yoklama",
            renk: Renk.kirmizi,
          ),
        ],
      ),
    );
  }
}
