import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/model/anasayfa_oge.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/widget/kare_yuvarlak_buton.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/widget/serit.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/yemek/yemek_giris.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/geri_boolean.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ogretmen/c_ogretmen.dart';
import 'ders_program/ders_programi_giris.dart';
import 'duyuru/duyuru_giris.dart';
import 'etkinlikler/etkinlikler_giris.dart';
import 'gunluk_akis/gunluk_akis_giris.dart';
import 'hakkimizda/hakkimizda_giris.dart';

late COgretmen _c;
List<AnasayfaOge> anasayfa = [];
List<Widget> anasayfaList = [];

class OgretmenAnasayfaGiris extends StatefulWidget {
  const OgretmenAnasayfaGiris({Key? key}) : super(key: key);

  @override
  State<OgretmenAnasayfaGiris> createState() => _OgretmenAnasayfaGirisState();
}

class _OgretmenAnasayfaGirisState extends State<OgretmenAnasayfaGiris> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: CachedNetworkImageProvider(cp.okul!.data.logo),
          //   fit: BoxFit.fitWidth,
          //   opacity: 0.2,
          // ),
          ),
      child: SingleChildScrollView(
        child: Column(
          children: anasayfaList,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    anasayfaList.clear();
    anasayfa.clear();
    _c = Get.find(tag: "cogretmen");
    /*ogretmenButonlari:
            "canliYayin": true,
            "dersProgrami": true,/
            "yemekMenusu": true,/
            "hakkimizda": true,/
            "yoklama": true,
            "gunlukAkis": true,/
            "duyuru": true,/
            "mesajlar": true,
            "etkinlik": true/
     */
    // cp.okulAyarlarList[cp.okulIndex].data.ogretmenButonlari["duyuru"] = false;
    if (cp.okulAyarlar.data.ogretmenButonlari["gunlukAkis"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Günlük Akış",
          image: "asset/image/gunluk_akis.svg",
          color: Renk.kirmizi,
          sayfa: OgretmenGunlukAkisGiris(c: _c),
          komut: () {
            _c.syfGunlukAkis.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenGunlukAkisGiris(c: _c));
          },
        ),
      );
    }
    if (cp.okulAyarlar.data.ogretmenButonlari["etkinlik"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Etkinlikler",
          image: "asset/image/etkinlikler.svg",
          color: Renk.turuncu,
          sayfa: OgretmenEtkinliklerGiris(c: _c),
          komut: () {
            _c.syfEtkinlikler.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenEtkinliklerGiris(c: _c));
          },
        ),
      );
    }

    if (cp.okulAyarlar.data.ogretmenButonlari["yemekMenusu"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Yemek Menüsü",
          image: "asset/image/yemek_menu.svg",
          color: Renk.yesil,
          sayfa: OgretmenYemekGiris(c: _c),
          komut: () {
            _c.syfYemekMenu.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenYemekGiris(c: _c));
          },
        ),
      );
    }

    if (cp.okulAyarlar.data.ogretmenButonlari["dersProgrami"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Ders Programı",
          image: "asset/image/ders_programi.svg",
          color: Renk.maviAcik,
          sayfa: OgretmenDersProgramGiris(c: _c),
          komut: () {
            _c.syfDersProgram.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenDersProgramGiris(c: _c));
          },
        ),
      );
    }

    if (cp.okulAyarlar.data.ogretmenButonlari["duyuru"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Haber / Duyurular",
          image: "asset/image/haber_duyurular.svg",
          color: Renk.turuncu,
          sayfa: OgretmenDuyuruGiris(c: _c),
          komut: () {
            _c.syfDuyuru.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenDuyuruGiris(c: _c));
          },
        ),
      );
    }
    if (cp.okulAyarlar.data.ogretmenButonlari["hakkimizda"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: _c,
          text: "Hakkımızda",
          image: "asset/image/hakkimizda.svg",
          color: Renk.kirmizi,
          sayfa: OgretmenHakkimizda(),
          komut: () {
            _c.syfHakkinda.value = true;
            _c.anasayfaSayfalari.clear();
            geri = false; //geri buton kontrolü
            _c.anasayfaSayfalari.add(OgretmenHakkimizda());
          },
        ),
      );
    }
    for (int i = 0; i < anasayfa.length - 1; i = i + 2) {
      anasayfaList.add(serit(
          c: anasayfa[i].c,
          solText: anasayfa[i].text,
          solImage: anasayfa[i].image,
          solColor: Renk.numaraliRenk(i),
          solSayfa: anasayfa[i].sayfa,
          solKomut: anasayfa[i].komut,
          sagText: anasayfa[i + 1].text,
          sagImage: anasayfa[i + 1].image,
          sagColor: Renk.numaraliRenk(i + 1),
          sagSayfa: anasayfa[i + 1].sayfa,
          sagKomut: anasayfa[i + 1].komut,
          cizgi: Renk.numaraliRenk(i)));
    }
    if (anasayfa.length % 2 == 1) {
      anasayfaList.add(kareYuvarlak(
          text: anasayfa.last.text,
          image: anasayfa.last.image,
          renk: anasayfa.last.color,
          acilacakSayfa: anasayfa.last.sayfa,
          c: anasayfa.last.c));
    }
  }
}
