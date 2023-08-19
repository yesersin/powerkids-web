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

import '../../../../const/shared_pref_keys.dart';
import '../../../../helper/locale_gonder.dart';
import '../../../../helper/shared_pref.dart';
import '../../../../service/kullanici/kullanici_update.dart';
import '../../../../static/hata_mesaj.dart';

class OgretmenKisiselBilgiler extends StatefulWidget {
  COgretmen c;

  OgretmenKisiselBilgiler({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenKisiselBilgiler> createState() => _OgretmenKisiselBilgilerState();
}

class _OgretmenKisiselBilgilerState extends State<OgretmenKisiselBilgiler> {
  TextEditingController yeniIsim = TextEditingController();
  TextEditingController yeniSifre = TextEditingController();
  TextEditingController yeniSifre2 = TextEditingController();
  bool sifreDegisti = false;
  bool dogumDegisti = false;
  bool isimDegisti = false;

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
            Obx(() {
              return beyazCard(
                baslik: "Ad Soyad",
                icerik: beyazCardAltMenu(
                  komut: () {
                    yeniIsim.text = (widget.c.profilAdSoyad.value);
                    Pencere().ac(
                        baslik: "Ad Soyad",
                        yukseklik: 150,
                        content: Column(children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: yeniIsim,
                              )),
                            ],
                          ),
                          SizedBox(width: 0, height: 10),
                          Buton().mavi(
                              click: () {
                                if (yeniIsim.text.length < 4) {
                                  toast(msg: "İsim en az 4 karakter olmalıdır.");
                                  return;
                                }
                                widget.c.profilAdSoyad.value = yeniIsim.text;
                                isimDegisti = true;
                                Get.back();
                              },
                              text: "Tamam"),
                        ]),
                        context: context);
                  },
                  svgIcon: "asset/image/edit_duzenle.svg",
                  c: widget.c,
                  svgImage: "asset/image/profil_kisisel.svg",
                  text: widget.c.profilAdSoyad.value,
                ),
              );
            }),
            SizedBox(width: 0, height: 10),
            beyazCard(
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
                                toast(msg: "Şifre en az 6 karakter olmalıdır.");
                                return;
                              }
                              if (yeniSifre.text != yeniSifre2.text) {
                                toast(msg: "Şifreler birbirinden farklı.");
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
            ),
            SizedBox(width: 0, height: 10),
            Obx(() {
              return beyazCard(
                baslik: "Doğum Günü",
                icerik: beyazCardAltMenu(
                  komut: () async {
                    DateTime? c = await showDatePicker(
                      context: context,
                      initialDate: widget.c.profilDogumTarihi.value,
                      firstDate: DateTime.now().subtract(Duration(days: 27550)),
                      lastDate: DateTime.now(),
                      locale: getLocale(dil: cp.dil),
                    );
                    if (c == null) {
                      debugPrint("seçilmedi");
                    } else {
                      dogumDegisti = true;
                      widget.c.profilDogumTarihi.value = c;
                    }
                  },
                  c: widget.c,
                  svgImage: "asset/image/profil_mail.svg",
                  text: Tarih().gunAyYil(widget.c.profilDogumTarihi.value),
                  svgIcon: "asset/image/edit_duzenle.svg",
                ),
              );
            }),
            SizedBox(width: 0, height: 10),
            Buton().mavi(
                click: () async {
                  Get.context!.loaderOverlay.show();
                  Map<String, String> body = {};
                  // if (yeniIsim.text.length < 4) {
                  //   toast(msg: "İsim en az 4 karakter olmalıdır.");
                  //   return;
                  // }
                  //
                  if (sifreDegisti) {
                    debugPrint("şifre eklendi");
                    body.addAll({"sifre": yeniSifre.text});
                  }
                  if (dogumDegisti) {
                    debugPrint("dogum eklendi");

                    body.addAll(
                        {"dogumTarihi": widget.c.profilDogumTarihi.value.toIso8601String()});
                  }
                  if (isimDegisti) {
                    debugPrint("isim eklendi");

                    body.addAll({"adSoyad": widget.c.profilAdSoyad.value});
                  }

                  body.addAll({"_id": cp.kullanici.data.id});
                  ModelKullaniciUpdate? kullanici = await kullaniciUpdate(
                    token: cp.kullanici.token,
                    body: body,
                  );

                  if (kullanici == null) {
                    toast(msg: hataMesaj);
                  } else {
                    cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
                    toast(msg: "Kullanıcı bilgileri güncellendi.");
                    if (sifreDegisti) {
                      Shared().save(key: SharedKeys().sifre, value: keyToMd5(yeniSifre.text));
                      debugPrint("şifre kaydedildi:" + keyToMd5(yeniSifre.text));
                    }
                  }

                  Get.context!.loaderOverlay.hide();
                },
                text: "Kaydet"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("kişisel giriş init");
    widget.c.profilAdSoyad.value = cp.kullanici.data.adSoyad;
    widget.c.profilSifre.value = cp.kullanici.data.sifre;
    widget.c.profilDogumTarihi.value = cp.kullanici.data.dogumTarihi;
  }
}
