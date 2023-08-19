import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../helper/locale_gonder.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../../service/ogrenci/ogrenci_update.dart';
import '../../../../../../static/hata_mesaj.dart';

class OgrenciKisiselBilgiler extends StatefulWidget {
  COgretmen c;

  OgrenciKisiselBilgiler({Key? key, required this.c}) : super(key: key);

  @override
  State<OgrenciKisiselBilgiler> createState() => _OgrenciKisiselBilgilerState();
}

class _OgrenciKisiselBilgilerState extends State<OgrenciKisiselBilgiler> {
  TextEditingController yeniIsim = TextEditingController();
  TextEditingController yeniSifre = TextEditingController();
  TextEditingController yeniSifre2 = TextEditingController();
  TextEditingController yeniKimlikNo = TextEditingController();
  bool sinifDegisti = false;
  bool dogumDegisti = false;
  bool isimDegisti = false;
  bool kimlikNoDegisti = false;

  @override
  Widget build(BuildContext context) {
    Get.context!.loaderOverlay.hide();
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
            adSoyad(context),
            SizedBox(width: 0, height: 10),
            sinif(context),
            SizedBox(width: 0, height: 10),
            dogumGunu(context),
            SizedBox(width: 0, height: 10),
            kimlikNo(context),
            SizedBox(width: 0, height: 10),
            kaydet()
          ],
        ),
      ),
    );
  }

  Widget adSoyad(BuildContext context) {
    return Obx(() {
      return beyazCard(
        baslik: "Ad Soyad",
        icerik: beyazCardAltMenu(
          komut: () {
            yeniIsim.text = widget.c.profilOgrenciAdSoyad.value;
            Pencere().ac(
                baslik: "Ad Soyad",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Textfield().text(
                              controller: yeniIsim,
                              onSubmit: (String text) {},
                              textRenk: Colors.black)),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (yeniIsim.text.length < 2) {
                          toast(msg: "İsim en az 2 karakter olmalıdır.");
                          return;
                        }
                        widget.c.profilOgrenciAdSoyad.value = yeniIsim.text;
                        debugPrint("yeni isim:" + widget.c.profilOgrenciAdSoyad.value);
                        isimDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          c: widget.c,
          svgImage: "asset/image/profil_kisisel.svg",
          text: widget.c.profilOgrenciAdSoyad.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
  }

  Widget sinif(BuildContext context) {
    return Obx(
      () => beyazCard(
        baslik: "Sınıfı",
        icerik: beyazCardAltMenu(
          komut: () {
            Pencere().ac(
                baslik: "Sınıf Değiştir",
                yukseklik: 300,
                content: Column(
                    children: cp.siniflar.data
                        .map(
                          (e) => Column(
                            children: [
                              Buton().mavi(
                                  click: () {
                                    widget.c.profilOgrenciSinif.value = e.sinifAdi;
                                    widget.c.profilOgrenciSinifId.value = e.id;
                                    sinifDegisti = true;
                                    Get.back();
                                  },
                                  text: e.sinifAdi),
                              SizedBox(width: 0, height: 10),
                            ],
                          ),
                        )
                        .toList()),
                context: context);
          },
          c: widget.c,
          svgImage: "asset/image/profil_sinif.svg",
          text: widget.c.profilOgrenciSinif.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      ),
    );
  }

  Widget dogumGunu(BuildContext context) {
    return Obx(() {
      return beyazCard(
        baslik: "Doğum Günü",
        icerik: beyazCardAltMenu(
          komut: () async {
            DateTime? c = await showDatePicker(
              context: context,
              initialDate: widget.c.profilOgrenciDogumTarihi.value,
              firstDate: DateTime.now().subtract(Duration(days: 27550)),
              lastDate: DateTime.now(),
              locale: getLocale(dil: cp.dil),
            );
            if (c == null) {
              debugPrint("seçilmedi");
            } else {
              dogumDegisti = true;
              widget.c.profilOgrenciDogumTarihi.value = c;
              widget.c.profilDogumTarihiText = c.toIso8601String();
            }
          },
          c: widget.c,
          svgImage: "asset/image/profil_mail.svg",
          text: Tarih().gunAyYil(widget.c.profilOgrenciDogumTarihi.value),
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
  }

  Widget kimlikNo(BuildContext context) {
    return Obx(() {
      return beyazCard(
        baslik: "Kimlik No",
        icerik: beyazCardAltMenu(
          komut: () async {
            yeniKimlikNo.text = (widget.c.profilOgrenciKimlikNo.value);

            Pencere().ac(
                baslik: "TC Kimlik No",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Textfield().text(
                              controller: yeniKimlikNo,
                              onSubmit: (String text) {},
                              textRenk: Colors.black)),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        yeniKimlikNo.text = yeniKimlikNo.text.replaceAll(RegExp(r"\D"), "");
                        if (yeniKimlikNo.text.length != 11) {
                          toast(msg: "Kimlik no 11 karakter olmalıdır.");
                          return;
                        }
                        widget.c.profilOgrenciKimlikNo.value = yeniKimlikNo.text;
                        kimlikNoDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          c: widget.c,
          svgImage: "asset/image/profil_mail.svg",
          text: widget.c.profilOgrenciKimlikNo.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
  }

  Widget kaydet() {
    return Buton().mavi(
        click: () async {
          Get.context!.loaderOverlay.show();
          Map<String, String> body = {};
          if (isimDegisti) {
            debugPrint("isim eklendi:" + yeniIsim.text);
            body.addAll({"adSoyad": yeniIsim.text});
          }
          if (sinifDegisti) {
            debugPrint("sınıf eklendi:" + widget.c.profilOgrenciSinifId.value);
            body.addAll({"sinifId": widget.c.profilOgrenciSinifId.value});
          }
          if (dogumDegisti) {
            debugPrint("dogum eklendi:" + widget.c.profilDogumTarihiText);
            body.addAll({"dogumTarihi": widget.c.profilDogumTarihiText});
          }
          if (kimlikNoDegisti) {
            debugPrint("kimlik eklendi:" + widget.c.profilOgrenciKimlikNo.value);
            body.addAll({"kimlikNo": widget.c.profilOgrenciKimlikNo.value});
          }

          body.addAll({"_id": widget.c.profilSecilenOgrenci.value.id});
          ModelOgrenciUpdateCevap? ogrenci = await ogrenciUpdate(
            token: cp.kullanici.token,
            body: body,
          );

          if (ogrenci == null) {
            toast(msg: hataMesaj);
          } else {
            widget.c.profilSecilenOgrenci.value = ogrenci.data.ogrenciyeDonustur();
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
    widget.c.profilOgrenciAdSoyad.value = widget.c.profilSecilenOgrenci.value.adSoyad;
    widget.c.profilOgrenciSinif.value = cp.siniflar.data
        .firstWhere((element) => element.id == widget.c.profilSecilenOgrenci.value.sinifId)
        .sinifAdi;
    widget.c.profilOgrenciDogumTarihi.value = widget.c.profilSecilenOgrenci.value.dogumTarihi;
    debugPrint("kimlikno:" + widget.c.profilSecilenOgrenci.value.kimlikNo);
    widget.c.profilOgrenciKimlikNo.value = widget.c.profilSecilenOgrenci.value.kimlikNo;
    // widget.c.profilOgrenciKimlikNo.value = "55555555555";//geçici
  }
}
