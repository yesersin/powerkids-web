import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_update.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../const/shared_pref_keys.dart';
import '../../../../../../helper/locale_gonder.dart';
import '../../../../../../helper/shared_pref.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../../service/kullanici/kullanici_update.dart';
import '../../../../../../service/ogrenci/ogrenci_update.dart';
import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/hata_mesaj.dart';

class OgrenciKisiselBilgiler extends StatefulWidget {
  COgretmen c;

  OgrenciKisiselBilgiler({Key? key, required this.c}) : super(key: key);

  @override
  State<OgrenciKisiselBilgiler> createState() => _OgrenciKisiselBilgilerState();
}

class _OgrenciKisiselBilgilerState extends State<OgrenciKisiselBilgiler> {
  TextEditingController yeniIsim = TextEditingController();
  TextEditingController veliyeniIsim = TextEditingController();
  TextEditingController yeniSifre = TextEditingController();
  TextEditingController yeniSifre2 = TextEditingController();
  TextEditingController yeniKimlikNo = TextEditingController();
  TextEditingController telefonText = TextEditingController();

  bool dogumDegisti = false;
  bool isimDegisti = false;
  bool sifreDegisti = false;
  bool veliisimDegisti = false;
  bool kimlikNoDegisti = false;
  bool telefonDegisti = false;

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
            dogumGunu(context),
            SizedBox(width: 0, height: 10),
            kimlikNo(context),
            SizedBox(width: 0, height: 10),
            veliAdSoyad(context),
            SizedBox(width: 0, height: 10),
            telefon(context),
            SizedBox(width: 0, height: 10),
            sifre(context),
            SizedBox(width: 0, height: 10),
            bildirim(),
            SizedBox(width: 0, height: 10),
            kaydet(),
            SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  Widget bildirim() {
    return beyazCard(
        baslik: "Bildirim",
        icerik: beyazCardAltMenu(
            c: co,
            svgImage: "asset/image/bildirim_turuncu.svg",
            text: "Bildirim",
            rightWidget: Obx(() {
              return Switch(
                  value: co.profilGorunme.value,
                  onChanged: (value) async {
                    Get.context!.loaderOverlay.show();
                    Map<String, String> body = {};
                    body.addAll({"_id": cp.kullanici.data.id});
                    body.addAll({"bildirim": value.toString()});
                    ModelKullaniciUpdate? kullanici = await kullaniciUpdate(
                      token: cp.kullanici.token,
                      body: body,
                    );

                    if (kullanici == null) {
                      toast(msg: hataMesaj);
                    } else {
                      cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
                      toast(msg: "Kullanıcı bilgileri güncellendi.");
                      co.profilGorunme.value = value;
                    }

                    Get.context!.loaderOverlay.hide();
                  });
            })));
  }

  Widget sifre(BuildContext context) {
    return beyazCard(
      baslik: "Şifre",
      icerik: beyazCardAltMenu(
        komut: () {
          Pencere().ac(
              baslik: "Şifre Değiştir",
              yukseklik: 250,
              content: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Textfield().text(
                        controller: yeniSifre,
                        hint: "Yeni şifre girin",
                        textRenk: Colors.black,
                        onSubmit: (text) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 0, height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Textfield().text(
                        controller: yeniSifre2,
                        hint: "Yeni şifre tekrar girin",
                        textRenk: Colors.black,
                        onSubmit: (text) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 0, height: 10),
                Buton().mavi(
                    click: () {
                      if (yeniSifre.text.length < 6) {
                        toast(msg: "Şifre en az 6 karakter olmalıdır!");
                        return;
                      }
                      if (yeniSifre.text != yeniSifre2.text) {
                        toast(msg: "Şifreler birbirinden farklı olamaz!");
                        return;
                      }
                      sifreDegisti = true;
                      widget.c.profilSifre.value = yeniSifre.text;
                      Get.back();
                    },
                    text: "Tamam"),
              ]),
              context: context);
        },
        c: widget.c,
        svgImage: "asset/image/profil_sinif.svg",
        text: "Şifreyi değiştirmek için tıklayın.",
        svgIcon: "asset/image/edit_duzenle.svg",
      ),
    );
  }

  Widget veliAdSoyad(BuildContext context) {
    return Obx(() {
      return beyazCard(
        baslik: "Veli Ad Soyad",
        icerik: beyazCardAltMenu(
          komut: () {
            veliyeniIsim.text = widget.c.profilAdSoyad.value;
            Pencere().ac(
                baslik: "Veli Ad Soyad",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: veliyeniIsim,
                      )),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (veliyeniIsim.text.length < 2) {
                          toast(msg: "İsim en az 2 karakter olmalıdır.");
                          return;
                        }
                        widget.c.profilAdSoyad.value = veliyeniIsim.text;
                        veliisimDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          c: widget.c,
          svgImage: "asset/image/ogretmenbilgi.svg",
          text: widget.c.profilAdSoyad.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
  }

  Widget telefon(BuildContext context) {
    return Obx(() {
      return beyazCard(
        baslik: "Telefon",
        icerik: beyazCardAltMenu(
          komut: () {
            telefonText.text = widget.c.profilTelefon.value;
            Pencere().ac(
                baslik: "Telefon",
                yukseklik: 150,
                content: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Textfield().text(
                              controller: telefonText,
                              onSubmit: (String text) {},
                              textRenk: Colors.black)),
                    ],
                  ),
                  SizedBox(width: 0, height: 10),
                  Buton().mavi(
                      click: () {
                        if (telefonText.text.length != 10) {
                          toast(msg: "Telefon 10 karakter olmalıdır!");
                          return;
                        }
                        widget.c.profilTelefon.value = telefonText.text;

                        telefonDegisti = true;
                        Get.back();
                      },
                      text: "Tamam"),
                ]),
                context: context);
          },
          c: widget.c,
          svgImage: "asset/image/telefon.svg",
          text: widget.c.profilTelefon.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
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
                        if (yeniIsim.text.length < 4) {
                          toast(msg: "İsim en az 4 karakter olmalıdır.");
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
          svgImage: "asset/image/ogretmenbilgi.svg",
          text: widget.c.profilOgrenciAdSoyad.value,
          svgIcon: "asset/image/edit_duzenle.svg",
        ),
      );
    });
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
          svgImage: "asset/image/takvim.svg",
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
          svgImage: "asset/image/kimlikno.svg",
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

          body = {};
          body.addAll({"_id": cp.kullanici.data.id});
          if (veliisimDegisti) {
            debugPrint("veli isim eklendi:" + veliyeniIsim.text);
            body.addAll({"adSoyad": veliyeniIsim.text});
          }
          if (telefonDegisti) {
            debugPrint("veli telefon eklendi:" + telefonText.text);
            body.addAll({"telefon": telefonText.text});
          }
          if (sifreDegisti) {
            debugPrint("veli şifre eklendi:" + yeniSifre.text);
            body.addAll({"sifre": yeniSifre.text});
          }
          ModelKullaniciUpdate? kullanici = await kullaniciUpdate(
            token: cp.kullanici.token,
            body: body,
          );

          if (kullanici == null) {
            toast(msg: hataMesaj);
          } else {
            cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
            toast(msg: "Veli bilgileri güncellendi.");
            if (sifreDegisti) {
              Shared().save(key: SharedKeys().sifre, value: keyToMd5(yeniSifre.text));
              debugPrint("şifre kaydedildi:" + keyToMd5(yeniSifre.text));
            }
          }

          Get.context!.loaderOverlay.hide();
        },
        text: "Kaydet");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.c.profilOgrenciAdSoyad.value = widget.c.profilSecilenOgrenci.value.adSoyad;
    widget.c.profilOgrenciSinif.value = cp.siniflar.data
        .firstWhere((element) => element.id == widget.c.profilSecilenOgrenci.value.sinifId)
        .sinifAdi;
    widget.c.profilOgrenciDogumTarihi.value = widget.c.profilSecilenOgrenci.value.dogumTarihi;
    widget.c.profilOgrenciKimlikNo.value = widget.c.profilSecilenOgrenci.value.kimlikNo;
    widget.c.profilTelefon.value = cp.kullanici.data.telefon;
    widget.c.profilGorunme.value = cp.kullanici.data.bildirim;
    widget.c.profilAdSoyad.value = cp.kullanici.data.adSoyad;
    // widget.c.profilOgrenciKimlikNo.value = "55555555555";//geçici
  }
}
