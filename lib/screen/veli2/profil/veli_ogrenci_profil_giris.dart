import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/boy.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/isim.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/kilo.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/ogrenci_kisisel_bilgiler.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/profil_foto.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/yuvarlak.dart';
import 'package:com.powerkidsx/screen/veli2/profil/psikolog_rapor/veli_ogrenci_psikolog_rapor.dart';
import 'package:com.powerkidsx/screen/veli2/profil/sinif_ogretmenleri/sinif_ogretmenleri_giris.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/card/beyazCardAltMenu.dart';
import '../../../component/card/beyaz_card.dart';
import '../../../component/custom/telefon_ara.dart';
import '../../../component/custom/yukleniyor.dart';
import '../../../const/renk.dart';
import '../../../helper/oturumu_kapat.dart';
import '../../../helper/tarih.dart';
import '../../../helper/toast.dart';
import '../../../helper/url_ac.dart';
import '../../../model/web_api/kullanici/kullanici_anything.dart';
import '../../../model/web_api/ogrenci/ogrenci_karti.dart';
import '../../../service/kullanici/kullanici_get_anything.dart';
import '../../../service/ogrenci/ogrenci_kart_getir.dart';
import '../../../static/cogretmen.dart';
import '../../../static/hata_mesaj.dart';
import '../../ogretmen/anasayfa/hakkimizda/hakkimizda_giris.dart';
import 'aile_karti/aile_karti_giris.dart';
import 'ogrenci_profilleri/etkinlik_gecmisi/ogrenci_etkinlik_gecmis.dart';
import 'ogrenci_profilleri/ilac_karti/ilac_saglik_karti.dart';
import 'ogrenci_profilleri/yoklama_gecmis2/ogrenci_yoklama_gecmis.dart';

class VeliOgrenciProfilGiris extends StatefulWidget {
  VeliOgrenciProfilGiris({Key? key}) : super(key: key);

  @override
  State<VeliOgrenciProfilGiris> createState() => _VeliOgrenciProfilGirisState();
}

class _VeliOgrenciProfilGirisState extends State<VeliOgrenciProfilGiris> {
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
        okulId: co.veliSecilenOgrenci.value.data.okulId,
        ogrenciId: co.veliSecilenOgrenci.value.data.id,
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
    debugPrint("öğrenci id:" + co.veliSecilenOgrenci.value.data.id);
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
          // key: PageStorageKey<String>(co.veliSecilenOgrenci.value.data.id),
          child: Obx(
            () => Column(
              children: [
                Obx(() =>
                    ogrenciProfilFoto(url: co.veliSecilenOgrenci.value.data.fotografUrl)),
                SizedBox(width: 0, height: 10),
                isim(isim: cp.kullanici.data.adSoyad),
                SizedBox(width: 0, height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star),
                        sinif(isim: cp.sinif.sinifAdi),
                      ],
                    ),
                    sinif(isim: "|"),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        sinif(isim: cp.kullanici.data.telefon),
                      ],
                    ),
                  ],
                ),
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
                ogretmenBilgiler(),
                SizedBox(width: 0, height: 10),
                yoklamaGecmisi(),
                SizedBox(width: 0, height: 10),
                etkinlikGecmisi(),
                SizedBox(width: 0, height: 10),
                psikologRapor(),
                SizedBox(width: 0, height: 10),
                ilacKarti(),
                SizedBox(width: 0, height: 10),
                aileKarti(),
                SizedBox(width: 0, height: 10),
                // adresBilgileri(),
                // SizedBox(width: 0, height: 10),

                beyazCard(
                  baslik: "Diğer",
                  icerik: Column(children: [
                    beyazCardAltMenu(
                      c: co,
                      svgImage: "asset/image/mail.svg",
                      text: "Bizimle İletişime Geçin",
                      sayfa: OgretmenHakkimizda(),
                      komut: () {
                        // c.pIletisim.value = true;
                        co.veliSayfalar[2] = OgretmenHakkimizda();
                        co.veliProfilSayfalari.add(OgretmenHakkimizda());
                      },
                    ),
                    SizedBox(width: 0, height: 10),
                    beyazCardAltMenu(
                      c: co,
                      svgImage: "asset/image/gizlilik_politika.svg",
                      text: "KVKK ve Gizlilik Politikası",
                      komut: () {
                        // c.pGizlilikPolitika.value = true;
                        urlAc(url: "http://www.powerkidsapp.com/m/kvkk");
                      },
                    ),
                  ]),
                ),
                SizedBox(width: 0, height: 10),
                beyazCard(
                  baslik: "Çıkış",
                  icerik: beyazCardAltMenu(
                    c: co,
                    svgImage: "asset/image/cikis.svg",
                    text: "Çıkış",
                    sayfa: null,
                    komut: () {
                      oturumuKapat();
                      // c.pCikis.value = true;
                    },
                  ),
                ),
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
          c: co,
          svgImage: "asset/image/ailekarti.svg",
          text: "Aile Kartı",
          sayfa: VeliOgrenciAileKarti(kart: kart!),
          komut: () {
            co.veliSayfalar[2] = VeliOgrenciAileKarti(kart: kart!);
            co.veliProfilSayfalari.add(VeliOgrenciAileKarti(kart: kart!));
          }),
    );
  }

  Widget ogretmenBilgiler() {
    debugPrint("sınıf id:" + cp.sinif.id);
    debugPrint("okul id:" + cp.okul!.data.id);
    return beyazCard(
      baslik: "Öğretmen Bilgileri",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/ogretmenbilgi.svg",
          text: "Öğretmen Bilgileri",
          sayfa: OgrenciSinifOgretmenleri(),
          komut: () async {
            co.veliSayfalar[2] = OgrenciSinifOgretmenleri();
            co.veliProfilSayfalari.add(OgrenciSinifOgretmenleri());
          }),
    );
  }

  Widget kisiselBilgiler() {
    return beyazCard(
      baslik: "Kişisel Bilgiler",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil.svg",
          text: "Kişisel Bilgiler",
          sayfa: OgrenciKisiselBilgiler(c: co),
          komut: () {
            debugPrint("click");
            co.veliSayfalar[2] = OgrenciKisiselBilgiler(c: co);
            co.veliProfilSayfalari.add(OgrenciKisiselBilgiler(c: co));
          }),
    );
  }

  Widget adresBilgileri() {
    return beyazCard(
      baslik: "Adres Bilgileri",
      icerik: Column(
        children: [
          beyazCardAltMenu(
            c: co,
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
        okulId: co.veliSecilenOgrenci.value.data.okulId,
        ogrenciId: co.veliSecilenOgrenci.value.data.id,
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
                    c: co,
                    svgImage: "asset/image/profil.svg",
                    text: element.adSoyad + (element.ebeveynMi ? " - Velisi" : ""),
                  ),
                  SizedBox(width: 0, height: 10),
                  beyazCardAltMenu(
                    c: co,
                    svgImage: "asset/image/takvim.svg",
                    text: Tarih().gunAyYilSaatDk(element.sonGirisTarihi),
                  ),
                  SizedBox(width: 0, height: 10),
                  // beyazCardAltMenu(
                  //   c: co,
                  //   svgImage: "asset/image/kan_grubu.svg",
                  //   text: "A+",
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 128,
                width: 128,
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
        c: co,
        svgImage: "asset/image/yoklama.svg",
        text: "Yoklama Geçmişi",
        sayfa: VeliOgrenciYoklamaGecmis(kart: kart!),
        komut: () {
          co.veliYoklamaSayfaEkleBtn.value = true;
          co.veliSayfalar[2] = VeliOgrenciYoklamaGecmis(kart: kart!);
          co.veliProfilSayfalari.add(VeliOgrenciYoklamaGecmis(kart: kart!));
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
        c: co,
        sayfa: VeliOgrenciEtkinlikGecmis(kart: kart!),
        komut: () {
          co.veliSayfalar[2] = VeliOgrenciEtkinlikGecmis(kart: kart!);
          co.veliProfilSayfalari.add(VeliOgrenciEtkinlikGecmis(kart: kart!));
        },
      ),
    );
  }

  Widget psikologRapor() {
    return beyazCard(
      baslik: "Psikolog Raporu",
      baslikOlsun: false,
      icerik: beyazCardAltMenu(
        svgImage: "asset/image/psikolog.svg",
        text: "Psikolog Raporu",
        c: co,
        sayfa: VeliOgrenciPsikologRaporGiris(kart: kart!),
        komut: () {
          co.veliSayfalar[2] = VeliOgrenciPsikologRaporGiris(kart: kart!);
          co.veliProfilSayfalari.add(VeliOgrenciPsikologRaporGiris(kart: kart!));
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
        c: co,
        sayfa: VeliOgrenciIlacSaglik(kart: kart!),
        komut: () {
          co.veliIlacSayfaEkleBtn.value = true;
          co.veliSayfalar[2] = VeliOgrenciIlacSaglik(kart: kart!);
          co.veliProfilSayfalari.add(VeliOgrenciIlacSaglik(kart: kart!));
        },
      ),
    );
  }

  Widget aylikYas() {
    return yuvarlak(
        sayi: Tarih().ayHesapla(co.veliSecilenOgrenci.value.data.dogumTarihi),
        altMetin: "Aylık",
        renk: Renk.yesil);
  }

  Widget sinif({required String isim}) {
    return Center(
      child: Text(isim, style: TextStyle(fontSize: 18, color: Renk.beyazMetin2)),
    );
  }
}
