import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/boy.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/isim.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/kilo.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/ogrenci_aile_karti.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/ogrenci_kisisel_bilgiler.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/profil_foto.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/profil_sayfasi/widget/yuvarlak.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/card/beyazCardAltMenu.dart';
import '../../../../../component/card/beyaz_card.dart';
import '../../../../../component/custom/telefon_ara.dart';
import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_karti.dart';
import '../../../../../service/kullanici/kullanici_get_anything.dart';
import '../../../../../service/ogrenci/ogrenci_kart_getir.dart';
import '../../../../../static/hata_mesaj.dart';
import '../etkinlik_gecmisi/ogrenci_etkinlik_gecmis.dart';
import '../ilac_karti/ilac_saglik_karti.dart';
import '../yoklama_gecmis2/ogrenci_yoklama_gecmis.dart';

class OgretmenOgrenciProfilAyrinti extends StatefulWidget {
  COgretmen c;

  OgretmenOgrenciProfilAyrinti({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenOgrenciProfilAyrinti> createState() => _OgretmenOgrenciProfilAyrintiState();
}

class _OgretmenOgrenciProfilAyrintiState extends State<OgretmenOgrenciProfilAyrinti> {
  ModelOgrenciKarti? kart;

  @override
  Widget build(BuildContext context) {
    if (kart == null) {
      return kartYukle();
    }
    return body();
  }

  Widget kartYukle() {
    return FutureBuilder(
      future: ogrenciKartGetir(
        token: cp.kullanici.token,
        okulId: widget.c.profilSecilenOgrenci.value.okulId,
        ogrenciId: widget.c.profilSecilenOgrenci.value.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelOgrenciKarti?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          toast(msg: hataMesaj);
          return Center(child: Text("Öğrenci kartı bulunamadı!", style: TextStyle()));
        }
        kart = snapshot.data!;
        return body();
      },
    );
  }

  Widget body() {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "asset/image/menu_arkaplan.png",
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          // key: PageStorageKey<String>(widget.c.profilSecilenOgrenci.value.id),
          child: Obx(
            () => Column(
              children: [
                ogrenciProfilFoto(url: widget.c.profilSecilenOgrenci.value.fotografUrl),
                SizedBox(width: 0, height: 10),
                isim(isim: widget.c.profilSecilenOgrenci.value.adSoyad),
                SizedBox(width: 0, height: 10),
                sinif(isim: "Sınıfı"),
                SizedBox(width: 0, height: 10),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      aylikYas(),
                      boy(kart: kart!),
                      kilo(kart: kart!),
                    ]),
                SizedBox(width: 0, height: 10),
                kisiselBilgiler(),
                SizedBox(width: 0, height: 10),
                yoklamaGecmisi(),
                SizedBox(width: 0, height: 10),
                etkinlikGecmisi(),
                SizedBox(width: 0, height: 10),
                ilacKarti(),
                SizedBox(width: 0, height: 10),
                aileKarti(),
                SizedBox(width: 0, height: 10),
                adresBilgileri(),
                SizedBox(width: 0, height: 10),
                veliBilgileri(),
                SizedBox(width: 0, height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget aileKarti() {
    return beyazCard(
      baslik: "Aile Kartı",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
          c: widget.c,
          svgImage: "asset/image/ailekarti.svg",
          text: "Aile Kartı",
          sayfa: OgrenciAileKarti(
            c: widget.c,
            kart: kart!,
          ),
          komut: () {
            widget.c.yoneticiProfilSayfalari.add(
              OgrenciAileKarti(
                c: widget.c,
                kart: kart!,
              ),
            );
            widget.c.yoneticiSayfalar[4] = OgrenciAileKarti(
              c: widget.c,
              kart: kart!,
            );
          }),
    );
  }

  Widget kisiselBilgiler() {
    return beyazCard(
      baslik: "Öğrenci Bilgiler",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
          c: widget.c,
          svgImage: "asset/image/profil.svg",
          text: "Öğrenci Bilgiler",
          sayfa: OgrenciKisiselBilgiler(
            c: widget.c,
          ),
          komut: () {
            widget.c.yoneticiProfilSayfalari.add(
              OgrenciKisiselBilgiler(c: widget.c),
            );
            widget.c.yoneticiSayfalar[4] = OgrenciKisiselBilgiler(c: widget.c);
          }),
    );
  }

  Widget adresBilgileri() {
    return beyazCard(
      baslik: "Adres Bilgileri",
      icerik: Column(
        children: [
          beyazCardAltMenu(
            c: widget.c,
            svgImage: "asset/image/konum.svg",
            text: kart!.data.detay.evAdresi,
          ),
        ],
      ),
    );
  }

  Widget veliBilgileri() {
    ModelKullaniciAnyThing? veli;
    return FutureBuilder(
      future: kullaniciGetAnythingGetir(
        token: cp.kullanici.token,
        okulId: widget.c.profilSecilenOgrenci.value.okulId,
        ogrenciId: widget.c.profilSecilenOgrenci.value.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelKullaniciAnyThing?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          // toast(msg: hataMesaj);
          return Center(child: Text("Veli bulunamadı :( " + hataMesaj, style: TextStyle()));
        }
        veli = snapshot.data!;
        return veliBilgileriIletisim(veli: veli!);
      },
    );
  }

  Widget veliBilgileriIletisim({required ModelKullaniciAnyThing veli}) {
    List<Widget> list = [];
    for (var element in veli.data) {
      list.add(beyazCard(
        baslik: "Veli Bilgileri",
        icerik: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  beyazCardAltMenu(
                    c: widget.c,
                    svgImage: "asset/image/profil.svg",
                    text: element.adSoyad + (element.ebeveynMi ? " - Velisi" : ""),
                  ),
                  SizedBox(width: 0, height: 10),
                  beyazCardAltMenu(
                    c: widget.c,
                    svgImage: "asset/image/takvim.svg",
                    text: Tarih().gunAyYilSaatDk(element.sonGirisTarihi),
                  ),
                  SizedBox(width: 0, height: 10),
                  // beyazCardAltMenu(
                  //   c: widget.c,
                  //   svgImage: "asset/image/kan_grubu.svg",
                  //   text: "A+",
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                width: 100,
                child: CachedNetworkImage(imageUrl: element.fotografUrl),
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ));
      list.add(SizedBox(width: 0, height: 10));
    }

    if (cp.kullanici.data.yetki.admin) {
      //admin ise iletişimi de ekle
      for (var element in veli.data) {
        list.add(beyazCard(
          baslik: "İletişim - " + element.adSoyad,
          icerik: telefonWidget(tel: element.telefon, whatsapp: element.telefon),
        ));
        list.add(SizedBox(width: 0, height: 10));
      }
    }

    return Column(children: list);
  }

  Widget yoklamaGecmisi() {
    return beyazCard(
      baslik: "Yoklama Geçmişi",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/yoklama.svg",
        text: "Yoklama Geçmişi",
        sayfa: OgretmenOgrenciYoklamaGecmis(kart: kart!),
        komut: () {
          widget.c.yoneticiProfilSayfalari.add(OgretmenOgrenciYoklamaGecmis(kart: kart!));
          widget.c.yoneticiSayfalar[4] = OgretmenOgrenciYoklamaGecmis(kart: kart!);
        },
      ),
    );
  }

  Widget etkinlikGecmisi() {
    return beyazCard(
      baslik: "Etkinlik Geçmişi",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
        svgImage: "asset/image/etkinlik.svg",
        text: "Etkinlik Geçmişi",
        c: widget.c,
        sayfa: OgretmenOgrenciEtkinlikGecmis(kart: kart!),
        komut: () {
          widget.c.yoneticiProfilSayfalari.add(OgretmenOgrenciEtkinlikGecmis(kart: kart!));
          widget.c.yoneticiSayfalar[4] = OgretmenOgrenciEtkinlikGecmis(kart: kart!);
        },
      ),
    );
  }

  Widget ilacKarti() {
    return beyazCard(
      baslik: "İlaç ve Sağlık Bilgisi",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
        svgImage: "asset/image/ilac.svg",
        text: "İlaç ve Sağlık Bilgisi",
        c: widget.c,
        sayfa: OgretmenOgrenciIlacSaglik(kart: kart!),
        komut: () {
          widget.c.yoneticiProfilSayfalari.add(OgretmenOgrenciIlacSaglik(kart: kart!));
          widget.c.yoneticiSayfalar[4] = OgretmenOgrenciIlacSaglik(kart: kart!);
        },
      ),
    );
  }

  Widget aylikYas() {
    return yuvarlak(
        sayi: Tarih().ayHesapla(widget.c.profilSecilenOgrenci.value.dogumTarihi),
        altMetin: "Aylık",
        renk: Renk.yesil);
  }

  Widget sinif({required String isim}) {
    return Center(
      child: Text(isim, style: TextStyle(fontSize: 18, color: Renk.beyazMetin2)),
    );
  }
}
