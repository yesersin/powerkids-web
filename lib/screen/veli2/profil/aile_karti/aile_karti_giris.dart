import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../model/web_api/ogrenci/ogrenci_karti.dart';
import '../../../../../../static/hata_mesaj.dart';
import '../../../../model/web_api/ogrenci/ogrenci_kart_up_cevap.dart';
import '../../../../service/ogrenci/ogrenci_kart_up.dart';
import '../../../../static/cogretmen.dart';

class VeliOgrenciAileKarti extends StatefulWidget {
  ModelOgrenciKarti kart;

  VeliOgrenciAileKarti({Key? key, required this.kart}) : super(key: key);

  @override
  State<VeliOgrenciAileKarti> createState() => _VeliOgrenciAileKartiState();
}

class _VeliOgrenciAileKartiState extends State<VeliOgrenciAileKarti> {
  bool ozelNotDegisti = false;
  bool yemekEgitimiDegisti = false;
  bool alerjikDurumDegisti = false;
  bool korkularDegisti = false;
  bool tuvaletEgitimiDegisti = false;
  bool saglikDurumuDegisti = false;
  bool aliskanliklariDegisti = false;
  TextEditingController ozelNotText = TextEditingController();
  TextEditingController yemekEgitimiText = TextEditingController();
  TextEditingController alerjikDurumText = TextEditingController();
  TextEditingController korkularText = TextEditingController();
  TextEditingController tuvaletEgitimiText = TextEditingController();
  TextEditingController saglikDurumuText = TextEditingController();
  TextEditingController aliskanliklariText = TextEditingController();

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 0, height: 10),
            ozelNot(context),
            SizedBox(width: 0, height: 10),
            yemekEgitimi(context),
            SizedBox(width: 0, height: 10),
            alerjikDurumu(context),
            SizedBox(width: 0, height: 10),
            korkulari(context),
            SizedBox(width: 0, height: 10),
            tuvaletEgitimi(context),
            SizedBox(width: 0, height: 10),
            saglikDurumu(context),
            SizedBox(width: 0, height: 10),
            aliskanliklari(context),
            SizedBox(width: 0, height: 10),
            kaydet(),
            SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  Widget ozelNot(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Özel Not",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiOzelNot.value,
          komut: () {
            ozelNotText.text = co.veliAileKartiOzelNot.value;
            Pencere().ac(
                baslik: "Özel Not",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: ozelNotText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (ozelNotText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiOzelNot.value = ozelNotText.text;
                        ozelNotDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget yemekEgitimi(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Yemek Eğitimi",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiYemekEgitimi.value,
          komut: () {
            yemekEgitimiText.text = co.veliAileKartiYemekEgitimi.value;
            Pencere().ac(
                baslik: "Yemek Eğitimi Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: yemekEgitimiText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (yemekEgitimiText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiYemekEgitimi.value = yemekEgitimiText.text;
                        yemekEgitimiDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget alerjikDurumu(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Alerjik Durumu",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiAlerjikDurumu.value,
          komut: () {
            alerjikDurumText.text = co.veliAileKartiAlerjikDurumu.value;
            Pencere().ac(
                baslik: "Alerjik Durum Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: alerjikDurumText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (alerjikDurumText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiAlerjikDurumu.value = alerjikDurumText.text;
                        alerjikDurumDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget korkulari(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Korkuları",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiKorkular.value,
          komut: () {
            korkularText.text = co.veliAileKartiKorkular.value;
            Pencere().ac(
                baslik: "Korku Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: korkularText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (korkularText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiKorkular.value = korkularText.text;
                        korkularDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget tuvaletEgitimi(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Tuvalet Eğitimi",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiTuvaletEgitimi.value,
          komut: () {
            tuvaletEgitimiText.text = co.veliAileKartiTuvaletEgitimi.value;
            Pencere().ac(
                baslik: "Tuvalet Eğitimi Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: tuvaletEgitimiText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (tuvaletEgitimiText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiTuvaletEgitimi.value = tuvaletEgitimiText.text;
                        tuvaletEgitimiDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget saglikDurumu(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Sağlık Durumu",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiSaglikDurumu.value,
          komut: () {
            saglikDurumuText.text = co.veliAileKartiSaglikDurumu.value;
            Pencere().ac(
                baslik: "Sağlık Durumu Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: saglikDurumuText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (saglikDurumuText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiSaglikDurumu.value = saglikDurumuText.text;
                        saglikDurumuDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget aliskanliklari(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Alışkanlıkları",
        icerik: beyazCardAltMenu(
          c: co,
          svgImage: "asset/image/profil_kisisel.svg",
          text: co.veliAileKartiAliskanliklari.value,
          komut: () {
            aliskanliklariText.text = co.veliAileKartiAliskanliklari.value;
            Pencere().ac(
                baslik: "Alışkanlıklar Notu",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: aliskanliklariText,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (aliskanliklariText.text.length < 4) {
                          toast(msg: "Özel not en az 4 karakter olmalıdır.");
                          return;
                        }
                        co.veliAileKartiAliskanliklari.value = aliskanliklariText.text;
                        aliskanliklariDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget kaydet() {
    return Buton().mavi(
        click: () async {
          // "aileFormu": {
          // "ozelNot": "",
          // "yemekEgitimi": "",
          // "alerjikDurumu": "",
          // "korkulari": "",
          // "tuvaletEgitimi": "",
          // "saglikDurumu": "",
          // "aliskanliklari": ""
          // },
          Get.context!.loaderOverlay.show();
          Map<String, String> bodyAlt = {};
          if (ozelNotDegisti) {
            debugPrint("ozelNotDegisti eklendi:" + ozelNotText.text);
            bodyAlt.addAll({"ozelNot": ozelNotText.text});
          } else {
            bodyAlt.addAll({"ozelNot": widget.kart.data.aileFormu.ozelNot});
          }

          if (yemekEgitimiDegisti) {
            debugPrint("yemekEgitimiText eklendi:" + yemekEgitimiText.text);
            bodyAlt.addAll({"yemekEgitimi": yemekEgitimiText.text});
          } else {
            bodyAlt.addAll({"yemekEgitimi": widget.kart.data.aileFormu.yemekEgitimi});
          }

          if (alerjikDurumDegisti) {
            debugPrint("alerjikDurumText eklendi:" + alerjikDurumText.text);
            bodyAlt.addAll({"alerjikDurumu": alerjikDurumText.text});
          } else {
            bodyAlt.addAll({"alerjikDurumu": widget.kart.data.aileFormu.yemekEgitimi});
          }

          if (korkularDegisti) {
            debugPrint("korkularText eklendi:" + korkularText.text);
            bodyAlt.addAll({"korkulari": korkularText.text});
          } else {
            bodyAlt.addAll({"korkulari": widget.kart.data.aileFormu.korkulari});
          }

          if (tuvaletEgitimiDegisti) {
            debugPrint("tuvaletEgitimiText eklendi:" + tuvaletEgitimiText.text);
            bodyAlt.addAll({"tuvaletEgitimi": tuvaletEgitimiText.text});
          } else {
            bodyAlt.addAll({"tuvaletEgitimi": widget.kart.data.aileFormu.tuvaletEgitimi});
          }

          if (saglikDurumuDegisti) {
            debugPrint("saglikDurumu eklendi:" + saglikDurumuText.text);
            bodyAlt.addAll({"saglikDurumu": saglikDurumuText.text});
          } else {
            bodyAlt.addAll({"saglikDurumu": widget.kart.data.aileFormu.saglikDurumu});
          }

          if (aliskanliklariDegisti) {
            debugPrint("saglikDurumu eklendi:" + aliskanliklariText.text);
            bodyAlt.addAll({"aliskanliklari": aliskanliklariText.text});
          } else {
            bodyAlt.addAll({"aliskanliklari": widget.kart.data.aileFormu.aliskanliklari});
          }

          ModelOgrenciKartUpCevap? ogrenci = await ogrenciKartUp(
            kartId: widget.kart.data.id,
            ogrenciId: widget.kart.data.ogrenciId,
            okulId: widget.kart.data.okulId,
            token: cp.kullanici.token,
            body: {"aileFormu": bodyAlt},
          );

          if (ogrenci == null) {
            toast(msg: hataMesaj);
          } else {
            // widget.c.profilSecilenOgrenci.value = ogrenci.data.ogrenciyeDonustur();
            // widget.c.profilSecilenOgrenci.refresh();
            toast(msg: "Öğrenci bilgileri güncellendi.");
          }

          Get.context!.loaderOverlay.hide();
        },
        text: "Kaydet");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("kişisel init");
    co.veliAileKartiOzelNot.value = widget.kart.data.aileFormu.ozelNot;
    co.veliAileKartiYemekEgitimi.value = widget.kart.data.aileFormu.yemekEgitimi;
    co.veliAileKartiAlerjikDurumu.value = widget.kart.data.aileFormu.alerjikDurumu;
    co.veliAileKartiKorkular.value = widget.kart.data.aileFormu.korkulari;
    co.veliAileKartiTuvaletEgitimi.value = widget.kart.data.aileFormu.tuvaletEgitimi;
    co.veliAileKartiSaglikDurumu.value = widget.kart.data.aileFormu.saglikDurumu;
    co.veliAileKartiAliskanliklari.value = widget.kart.data.aileFormu.aliskanliklari;
  }
}
