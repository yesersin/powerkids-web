import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/model/anasayfa_oge.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/widget/kare_yuvarlak_buton.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/widget/serit.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/yemek/yemek_giris.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/geri_boolean.dart';
import 'package:flutter/material.dart';

import '../../../static/cogretmen.dart';
import 'ders_program/ders_programi_giris.dart';
import 'duyuru/duyuru_giris.dart';
import 'gunluk_akis/gunluk_akis_giris.dart';
import 'hakkimizda/hakkimizda_giris.dart';
import 'helper/okula_gidiyorum.dart';
import 'odeme/veli_odeme_giris.dart';

List<AnasayfaOge> anasayfa = [];
List<Widget> anasayfaList = [];

class VeliAnasayfaGiris extends StatefulWidget {
  const VeliAnasayfaGiris({Key? key}) : super(key: key);

  @override
  State<VeliAnasayfaGiris> createState() => _VeliAnasayfaGirisState();
}

class _VeliAnasayfaGirisState extends State<VeliAnasayfaGiris> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(cp.okul!.data.logo),
          fit: BoxFit.fitWidth,
          opacity: 0.2,
        ),
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

    anasayfa.add(
      AnasayfaOge(
        c: co,
        text: "Günlük Akış",
        image: "asset/image/gunluk_akis.svg",
        color: Renk.kirmizi,
        sayfa: VeliGunlukAkisGiris(),
        komut: () {
          geri = false; //geri buton kontrolü
          co.veliAnasayfaSayfalari.clear();
          co.veliAnasayfaSayfalari.add(VeliGunlukAkisGiris());
          co.veliSayfalar[0] = VeliGunlukAkisGiris();
        },
      ),
    );

    anasayfa.add(
      AnasayfaOge(
        c: co,
        text: "Ders Programı",
        image: "asset/image/ders_programi.svg",
        color: Renk.maviAcik,
        sayfa: OgretmenDersProgramGiris(c: co),
        komut: () {
          // co.syfDersProgram.value = true;
          geri = false; //geri buton kontrolü
          co.veliAnasayfaSayfalari.clear();
          co.veliAnasayfaSayfalari.add(OgretmenDersProgramGiris(c: co));
          co.veliSayfalar[0] = OgretmenDersProgramGiris(c: co);
        },
      ),
    );

    anasayfa.add(
      AnasayfaOge(
        c: co,
        text: "Yemek Menüsü",
        image: "asset/image/yemek_menu.svg",
        color: Renk.yesil,
        sayfa: OgretmenYemekGiris(c: co),
        komut: () {
          // co.syfYemekMenu.value = true;
          geri = false; //geri buton kontrolü
          co.veliAnasayfaSayfalari.clear();
          co.veliAnasayfaSayfalari.add(OgretmenYemekGiris(c: co));
          co.veliSayfalar[0] = OgretmenYemekGiris(c: co);
        },
      ),
    );

    anasayfa.add(
      AnasayfaOge(
        c: co,
        text: "Haber / Duyurular",
        image: "asset/image/haber_duyurular.svg",
        color: Renk.turuncu,
        sayfa: OgretmenDuyuruGiris(c: co),
        komut: () {
          // co.syfDuyuru.value = true;
          geri = false; //geri buton kontrolü
          co.veliAnasayfaSayfalari.clear();
          co.veliAnasayfaSayfalari.add(OgretmenDuyuruGiris(c: co));
          co.veliSayfalar[0] = OgretmenDuyuruGiris(c: co);
        },
      ),
    );
    anasayfa.add(
      AnasayfaOge(
        c: co,
        text: "Hakkımızda",
        image: "asset/image/hakkimizda.svg",
        color: Renk.kirmizi,
        sayfa: OgretmenHakkimizda(),
        komut: () {
          // co.syfHakkinda.value = true;
          geri = false; //geri buton kontrolü
          co.veliAnasayfaSayfalari.clear();
          co.veliAnasayfaSayfalari.add(OgretmenHakkimizda());
          co.veliSayfalar[0] = OgretmenHakkimizda();
        },
      ),
    );

    // anasayfa.add(
    //   AnasayfaOge(
    //     c: co,
    //     text: "Okula Geliyorum",
    //     image: "asset/image/etkinlikler.svg",
    //     color: Renk.turuncu,
    //     sayfa: Text("okula geliyorum"),
    //     komut: () async {
    //       okulaGidiyorum();
    //       return;
    //       // co.syfEtkinlikler.value = true;
    //       geri = false; //geri buton kontrolü
    //       co.veliAnasayfaSayfalari.clear();
    //       co.veliAnasayfaSayfalari.add(Text("okula geliyorum"));
    //       co.veliSayfalar[0] = Text("okula geliyorum");
    //     },
    //   ),
    // );
    // cp.okulAyarlar.data.veliButonlar["odeme"]=true;//geçici
    if (cp.okulAyarlar.data.veliButonlar["odeme"] == true) {
      anasayfa.add(
        AnasayfaOge(
          c: co,
          text: "Ödeme",
          image: "asset/image/etkinlikler.svg",
          color: Renk.turuncu,
          sayfa: Text("Ödeme"),
          komut: () {
            // co.syfEtkinlikler.value = true;
            geri = false; //geri buton kontrolü
            co.veliAnasayfaSayfalari.clear();
            co.veliAnasayfaSayfalari.add(VeliOdemeGiris());
            co.veliSayfalar[0] = VeliOdemeGiris();
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
      anasayfaList.add(
        kareYuvarlak(
          text: anasayfa.last.text,
          image: anasayfa.last.image,
          renk: anasayfa.last.color,
          acilacakSayfa: anasayfa.last.sayfa,
          c: anasayfa.last.c,
          komut: anasayfa.last.komut,
        ),
      );
    }
    anasayfaList.add(SizedBox(width: 0, height: 50));
  }
}
