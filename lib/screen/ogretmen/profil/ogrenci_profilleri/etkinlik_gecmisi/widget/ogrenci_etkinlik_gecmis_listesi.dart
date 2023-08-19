import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../component/card/etkinlik_card.dart';
import '../../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../../helper/toast.dart';
import '../../../../../../service/ogrenci/ogrenci_etkinlik_update.dart';
import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/cprogram.dart';
import '../../../../../../static/hata_mesaj.dart';

Widget ogrenciEtkinlikGecmisListWidget() {
  return Obx(
    () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        shrinkWrap: true,
        itemCount: co.profilOgrenciGecmisEtkinlikList.value.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () async {
              if (DateTime.now().difference(co.profilOgrenciGecmisEtkinlikList[index].zaman) >
                  Duration(days: 2)) {
                return;
              }
              Pencere().ac(
                  yukseklik: 125,
                  content: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Etkinliği silmek istiyor musunuz?", style: TextStyle()),
                      MaterialButton(
                          color: Colors.red,
                          onPressed: () async {
                            Get.context!.loaderOverlay.show();
                            bool? sonuc = await updateOgrenciEtkinlikAkis(
                              token: cp.kullanici.token,
                              id: co.profilOgrenciGecmisEtkinlikList[index].id,
                              body: {"durum": "false"},
                            );
                            if (sonuc == null) {
                              Get.context!.loaderOverlay.hide();
                              toast(msg: hataMesaj);
                              return;
                            } else {
                              toast(msg: "Etkinlik silindi.");
                              co.profilOgrenciGecmisEtkinlikList.value.removeWhere((element) =>
                                  element.id == co.profilOgrenciGecmisEtkinlikList[index].id);

                              co.profilOgrenciGecmisEtkinlikList.refresh();
                              Get.back();
                            }
                            Get.context!.loaderOverlay.hide();
                          },
                          child: Text("Sil")),
                    ],
                  ),
                  context: Get.context!);
            },
            child: Column(
              children: [
                etkinlikCard(
                  saat: Tarih().saatDk(co.profilOgrenciGecmisEtkinlikList[index].zaman),
                  baslik: co.profilOgrenciGecmisEtkinlikList[index].etkinlikAdi,
                  mesaj: co.profilOgrenciGecmisEtkinlikList[index].tercih,
                  ogretmenAd: co.profilOgrenciGecmisEtkinlikList[index].ogretmenAdi,
                  renk: Renk.numaraliRenk(index),
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          );
        }),
  );
}
