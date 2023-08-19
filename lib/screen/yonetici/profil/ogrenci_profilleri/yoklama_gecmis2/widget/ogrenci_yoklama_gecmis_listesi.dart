import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../component/card/yoklamaCard.dart';
import '../../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../../helper/toast.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_yoklama_up_cevap.dart';
import '../../../../../../service/ogrenci/ogrenci_yoklama_update.dart';
import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/cprogram.dart';
import '../../../../../../static/hata_mesaj.dart';

Widget ogrenciYoklamaGecmisListWidget() {
  return Obx(
    () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        shrinkWrap: true,
        itemCount: co.profilOgrenciYoklamaGecmisList.value.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () async {
              debugPrint("yoklama id:" + co.profilOgrenciYoklamaGecmisList[index].id);
              if (DateTime.now().difference(co.profilOgrenciYoklamaGecmisList[index].zaman) >
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
                            ModelOgrenciYoklamaUpCevap? sonuc = await updateOgrenciYoklama(
                              token: cp.kullanici.token,
                              yoklamaDurum:
                                  co.profilOgrenciYoklamaGecmisList[index].yoklamaDurum,
                              id: co.profilOgrenciYoklamaGecmisList[index].id,
                              body: {"durum": "false"},
                            );
                            if (sonuc == null) {
                              Get.context!.loaderOverlay.hide();
                              toast(msg: hataMesaj);
                              return;
                            } else {
                              toast(msg: "Yoklama silindi.");
                              co.profilOgrenciYoklamaGecmisList.value.removeWhere((element) =>
                                  element.id == co.profilOgrenciYoklamaGecmisList[index].id);

                              co.profilOgrenciYoklamaGecmisList.refresh();
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
                yoklamaCard(
                  saat: Tarih().saatDk(co.profilOgrenciYoklamaGecmisList[index].zaman),
                  mesaj: co.profilOgrenciYoklamaGecmisList[index].mesaj,
                  yoklamaDurum: co.profilOgrenciYoklamaGecmisList[index].yoklamaDurum,
                  renk: Renk.numaraliRenk(index),
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          );
        }),
  );
}
