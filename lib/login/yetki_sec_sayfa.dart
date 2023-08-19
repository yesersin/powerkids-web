import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/const/yetki_text.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/login/widget/okul_adi.dart';
import 'package:com.powerkidsx/login/widget/ust_logo.dart';
import 'package:com.powerkidsx/login/widget/yetki_sec_btn.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul.dart';
import 'package:com.powerkidsx/screen/ogretmen/ogretmen_giris.dart';
import 'package:com.powerkidsx/screen/yonetici/yonetici_giris.dart';
import 'package:com.powerkidsx/service/kullanici/kullanici_get_notification_list.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../const/renk.dart';
import '../controller/ogretmen/c_ogretmen.dart';
import '../helper/ogrenci_sayisi.dart';
import '../model/web_api/anket/anket.dart';
import '../model/web_api/kullanici/kullanici_notification.dart';
import '../model/web_api/ogrenci/ogrenci_get.dart';
import '../screen/veli2/veli_giris.dart';
import '../service/anket/get_anket.dart';
import '../service/ogrenci/ogrenci_get_by_id.dart';
import '../service/okul/okul_getir.dart';
import '../static/cprogram.dart';
import '../static/yetki.dart';

class LoginYetkiSecSayfa extends StatefulWidget {
  const LoginYetkiSecSayfa({Key? key}) : super(key: key);

  @override
  State<LoginYetkiSecSayfa> createState() => _LoginYetkiSecSayfaState();
}

class _LoginYetkiSecSayfaState extends State<LoginYetkiSecSayfa> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: body(),
      ),
    );
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ustLogo(image: "asset/image/giris_ust.png"),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (1 != 1)
                  IconButton(
                      onPressed: () async {
                        ModelKullaniciNotification? s = await getKullaniciNotificationList(
                            okulId: cp.okul!.data.id,
                            sinifId: cp.sinif.id,
                            token: cp.kullanici.token);
                        s?.data.forEach((element) {
                          debugPrint(element.adSoyad);
                          debugPrint(element.notificationId);
                        });
                        // sendPushMessage(
                        //     a, Tarih().gunAyYilSaatDk(DateTime.now()), "title", "2");
                        // sendPushMessage(s14,"body","title","2");
                        // sendPushMessage("0a267390-a51c-44d3-9aed-72d36bed3a02","body","title","2");//12t
                      },
                      icon: Icon(Icons.read_more)),
                if ((yogretmen || ybrans) && cp.kullanici.data.yetki.ogretmen ||
                    cp.kullanici.data.yetki.brans)
                  ogretmen(),
                if (yveli && cp.kullanici.data.yetki.veli) veli(),
                if (yadmin && cp.kullanici.data.yetki.admin) yonetici(),
              ],
            ),
          ),
        ),
        Image.asset(
          "asset/image/giris_alt.png",
          width: Get.width * 0.8,
        )
      ],
    );
  }

  Widget yonetici() {
    return yetkiBtn(
      renk: Renk.yesil,
      text: "Yönetici",
      image: "asset/image/yonetici_logo.svg",
      sayfa: YoneticiGiris(),
      komut: () async {
        Get.context!.loaderOverlay.show();
        yetkiText = YetkiText.admin;
        //okul yükle
        List<ModelOkul> list = [];
        for (int i = 0; i < cp.kullanici.data.okulId.length; i++) {
          debugPrint(i.toString() + ":okul getiriliyor" + cp.kullanici.data.okulId[i]);
          ModelOkul? okul = await getOkul(okulId: cp.okul!.data.id, token: cp.kullanici.token);
          if (okul != null) list.add(okul);
        }
        debugPrint("öğrenci sayısı geliyor");
        cp.ogrenciSayisi = await ogrenciSayisiYukle();

        //okul yükle
        Get.context!.loaderOverlay.hide();
        if (list.isEmpty) {
          toast(msg: "okulbulunmadi".tr);
          Get.offAll(() => LoginYetkiSecSayfa());
          return;
        }

        if (list.length == 1) {
          debugPrint("1 tane okul var");
          cp.okul = list.first;
          Get.off(() => YoneticiGiris());
          return;
        }

        List<Widget> okullar = [];
        for (var element in list) {
          okullar.add(
            MaterialButton(
                onPressed: () {
                  cp.okul = element;
                  Get.off(() => YoneticiGiris());
                },
                child: okulAdi(isim: element.data.okulAdi)),
          );
        }

        await Pencere()
            .ac(content: Column(children: okullar), context: context, baslik: "okulsec".tr);
      },
    );
  }

  Widget veli() {
    Get.context!.loaderOverlay.hide(); //geçici
    return yetkiBtn(
        renk: Renk.maviAcik,
        text: "Veli",
        image: "asset/image/veli_logo.svg",
        sayfa: VeliGiris(),
        komut: () async {
          Get.context!.loaderOverlay.show();
          yetkiText = YetkiText.veli;
          co.veliOgrenciList.clear();
          for (var element in cp.kullanici.data.ogrenciId) {
            ModelOgrenciGet? ogrenci =
                await ogrenciGetir(id: element, token: cp.kullanici.token);
            if (ogrenci != null) {
              co.veliOgrenciList.add(ogrenci);
            }
          }
          if (co.veliOgrenciList.isNotEmpty) {
            co.veliSecilenOgrenci.value = co.veliOgrenciList.first;
            co.profilSecilenOgrenci.value =
                co.veliOgrenciList.first.data.modelOgrenciDonustur();
            int index = cp.siniflar.data
                .indexWhere((element) => co.profilSecilenOgrenci.value.sinifId == element.id);
            for (int i = 0; i < cp.siniflar.data.length; i++) {
              debugPrint("okul sınıfı:" + cp.siniflar.data[i].sinifAdi);
              debugPrint("okul sınıfı:" + cp.siniflar.data[i].id);
            }
            debugPrint("index:" + index.toString());
            if (index == -1) {
              if (cp.kullanici.data.yetki.veli) toast(msg: "ogrencisinifyok".tr);
              Get.context!.loaderOverlay.hide();
              Get.offAll(() => LoginYetkiSecSayfa());
            } else {
              cp.sinif = cp.siniflar.data[index];
            }
          }

          //anketleri yükle
          ModelAnket? anket =
              await getAnket(okulId: cp.okul!.data.id, dil: cp.dil, token: cp.kullanici.token);
          cp.anket = anket;
          //anketleri yükle

          Get.context!.loaderOverlay.hide();
        });
  }

  Widget ogretmen() {
    Get.context!.loaderOverlay.hide();
    return yetkiBtn(
        renk: Renk.turuncu,
        text: "ogretmen".tr,
        image: "asset/image/ogretmen_logo.svg",
        sayfa: OgretmenGiris(),
        komut: () async {
          yetkiText = YetkiText.ogretmen;
          Get.context!.loaderOverlay.show();
          //anketleri yükle
          ModelAnket? anket =
              await getAnket(okulId: cp.okul!.data.id, dil: cp.dil, token: cp.kullanici.token);
          cp.anket = anket;
          //anketleri yükle

          Get.context!.loaderOverlay.hide();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("kullanıcı id:" + cp.kullanici.data.id);
    co = Get.put(COgretmen(), tag: "cogretmen", permanent: true); //static öğretmen controller
  }
}
