import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../component/custom/button.dart';
import '../../../component/pencere/uyari_pencere.dart';
import '../../../controller/ogretmen/c_ogretmen.dart';
import '../../../helper/oturumu_kapat.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/kullanici/kullanici_update.dart';
import '../../../service/kullanici/kullanici_up_profil_resim.dart';
import '../../../service/kullanici/kullanici_update.dart';
import '../../../static/hata_mesaj.dart';
import '../anasayfa/hakkimizda/hakkimizda_giris.dart';
import 'kisisel_bilgiler/kisisel_bilgiler_giris.dart';
import 'ogrenci_profilleri/ogrenci_profil_liste.dart';

late COgretmen _c;

class OgretmenProfilGiris extends StatefulWidget {
  const OgretmenProfilGiris({Key? key}) : super(key: key);

  @override
  State<OgretmenProfilGiris> createState() => _OgretmenProfilGirisState();
}

class _OgretmenProfilGirisState extends State<OgretmenProfilGiris> {
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
            avatar(),
            SizedBox(width: 0, height: 10),
            isim(isim: cp.kullanici.data.adSoyad),
            // SizedBox(width: 0, height: 10),
            // brans(isim: "Bilişim Teknolojileri"),
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   mail(mail: "tekin@gmail.com"),
            //   telefon(telefon: "05462947291"),
            // ]),
            SizedBox(width: 0, height: 10),
            beyazCard(
              baslik: "Öğrencilerim",
              icerik: beyazCardAltMenu(
                svgImage: "asset/image/profil.svg",
                text: "Öğrenci Profilleri",
                c: _c,
                sayfa: OgrenciProfilleriListele(c: _c),
                komut: () {
                  _c.profilSayfalari.add(OgrenciProfilleriListele(c: _c));
                  // c.pOgrenciProfilleri.value = true;
                },
              ),
            ),
            SizedBox(width: 0, height: 10),
            beyazCard(
              baslik: "Hesap",
              icerik: Column(children: [
                beyazCardAltMenu(
                    c: _c,
                    svgImage: "asset/image/ogretmenbilgi.svg",
                    text: "Kişisel Bilgiler",
                    sayfa: OgretmenKisiselBilgiler(c: _c),
                    komut: () {
                      _c.profilSayfalari.add(OgretmenKisiselBilgiler(c: _c));
                    }),
                SizedBox(width: 0, height: 10),
                beyazCardAltMenu(
                    c: _c,
                    svgImage: "asset/image/star_yildiz.svg",
                    text: "Görünme",
                    rightWidget: Obx(() {
                      return Switch(
                          value: _c.profilGorunme.value,
                          onChanged: (value) async {
                            Get.context!.loaderOverlay.show();
                            Map<String, String> body = {};
                            body.addAll({"_id": cp.kullanici.data.id});
                            body.addAll({"gorunme": value.toString()});
                            ModelKullaniciUpdate? kullanici = await kullaniciUpdate(
                              token: cp.kullanici.token,
                              body: body,
                            );

                            if (kullanici == null) {
                              toast(msg: hataMesaj);
                            } else {
                              cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
                              toast(msg: "Kullanıcı bilgileri güncellendi.");
                              _c.profilGorunme.value = value;
                            }

                            Get.context!.loaderOverlay.hide();
                          });
                    })),
                // SizedBox(width: 0, height: 10),
                // beyazCardAltMenu(
                //   c: _c,
                //   svgImage: "asset/image/etkinlik_gecmisi.svg",
                //   text: "Etkinlik Geçmişi",
                //   sayfa: OgretmenEtkinlikGecmis(c: _c),
                //   komut: () {
                //     _c.profilSayfalari.add(OgretmenEtkinlikGecmis(c: _c));
                //     // c.pEtkinlikGecmisi.value = true;
                //   },
                // ),
              ]),
            ),
            SizedBox(width: 0, height: 10),
            beyazCard(
              baslik: "CV Bilgileri",
              icerik: Obx(() {
                return beyazCardAltMenu(
                  svgImage: "asset/image/kimlikno.svg",
                  text: _c.profilCVBilgiler.value,
                  c: _c,
                  komut: () {
                    TextEditingController cvText = TextEditingController();
                    cvText.text = _c.profilCVBilgiler.value;
                    Pencere().ac(
                        baslik: "CV Bilgileri",
                        yukseklik: 250,
                        content: Column(children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: cvText,
                                maxLines: 7,
                                minLines: 5,
                              )),
                            ],
                          ),
                          SizedBox(width: 0, height: 10),
                          Buton().mavi(
                              click: () async {
                                if (cvText.text.length < 4) {
                                  toast(msg: "CV en az 4 karakter olmalıdır.");
                                  return;
                                }
                                Get.context!.loaderOverlay.show();
                                Map<String, String> body = {};
                                body.addAll({"cv": cvText.text});
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
                                  _c.profilCVBilgiler.value = cvText.text;
                                }

                                Get.context!.loaderOverlay.hide();

                                Get.back();
                              },
                              text: "Tamam"),
                        ]),
                        context: context);
                  },
                );
              }),
            ),
            SizedBox(width: 0, height: 10),
            beyazCard(
              baslik: "Diğer",
              icerik: Column(children: [
                beyazCardAltMenu(
                  c: _c,
                  svgImage: "asset/image/mail.svg",
                  text: "Bizimle İletişime Geçin",
                  sayfa: OgretmenHakkimizda(),
                  komut: () {
                    // c.pIletisim.value = true;
                    _c.profilSayfalari.add(OgretmenHakkimizda());
                  },
                ),
                SizedBox(width: 0, height: 10),
                beyazCardAltMenu(
                  c: _c,
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
                c: _c,
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
    );
  }

  Widget avatar() {
    return GestureDetector(
      onTap: () async {
        late XFile? image;
        try {
          image = await ImagePicker().pickImage(imageQuality: 70, source: ImageSource.gallery);
        } catch (e) {
          toast(msg: "Seçilen dosya imaj değil:" + e.toString());
          return;
        }

        if (image == null) {
          return;
        }
        int size = await image.length();
        var bytes = await image.readAsBytes();
        PlatformFile secilenImaj =
            PlatformFile(name: image.name, path: image.path, size: size,bytes: bytes);
        Get.context!.loaderOverlay.show();
        ModelKullaniciUpdate? kullanici = await kullaniciProfilResimUpdate(
          file: secilenImaj,
          id: cp.kullanici.data.id,
          okulId: cp.okul!.data.id,
          token: cp.kullanici.token,
        );

        if (kullanici == null) {
          toast(msg: hataMesaj);
        } else {
          cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
          _c.profilFotoUrl.value = cp.kullanici.data.fotografUrl;
          toast(msg: "Profil fotoğrafı güncellendi.");
        }

        Get.context!.loaderOverlay.hide();
      },
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        width: 150,
        height: 150,
        // color: Colors.red,
        child: Center(
          child: Stack(
            children: [
              Obx(() {
                return CircleAvatar(
                  foregroundImage: NetworkImage(_c.profilFotoUrl.value),
                  radius: 150,
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Renk.turuncuCanli,
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.yellow,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget isim({required String isim}) {
    return Center(
      child: Text(isim,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          )),
    );
  }

  Widget brans({required String isim}) {
    return Center(
      child: Text(isim, style: TextStyle(fontSize: 18, color: Renk.beyazMetin2)),
    );
  }

  Widget mail({required String mail}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.mail,
          color: Renk.beyazMetin2,
        ),
      ),
      Text(
        mail,
        style: TextStyle(
          color: Renk.beyazMetin2,
        ),
      ),
    ]);
  }

  Widget telefon({required String telefon}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.phone,
            color: Renk.beyazMetin2,
          )),
      Text(telefon,
          style: TextStyle(
            color: Renk.beyazMetin2,
          )),
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _c = Get.find(tag: "cogretmen");
    _c.profilFotoUrl.value = cp.kullanici.data.fotografUrl;
    _c.profilGorunme.value = cp.kullanici.data.gorunme;
    _c.profilCVBilgiler.value = cp.kullanici.data.cv;
  }
}
