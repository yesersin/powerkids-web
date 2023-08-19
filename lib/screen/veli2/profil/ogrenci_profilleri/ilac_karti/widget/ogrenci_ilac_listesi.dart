import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_ilac.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../component/card/etkinlik_card.dart';
import '../../../../../../helper/toast.dart';
import '../../../../../../model/web_api/ilac/ilac_update_cevap.dart';
import '../../../../../../service/ogrenci/ogrenci_ilac_update.dart';
import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/cprogram.dart';
import '../../../../../../static/hata_mesaj.dart';

Widget ogrenciIlacListWidget() {
  return Obx(
    () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        shrinkWrap: true,
        itemCount: co.profilOgrenciIlacList.value.length,
        itemBuilder: (context, index) {
          debugPrint("seçenek:" + co.profilOgrenciIlacList[index].secenek);
          return GestureDetector(
            onLongPress: () async {},
            child: Column(
              children: [
                etkinlikCard(
                  saat: Tarih().saatDk(co.profilOgrenciIlacList[index].createdAt),
                  baslik: co.profilOgrenciIlacList[index].ilacAdi,
                  mesaj: co.profilOgrenciIlacList[index].mesaj +
                      "\n" +
                      "Not: " +
                      co.profilOgrenciIlacList[index].not,
                  ogretmenAd: co.profilOgrenciIlacList[index].goruldu ? "Görüldü" : "",
                  renk: Renk.griArkaplanKoyu,
                  altEkstra: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      evetHayir(ilac: co.profilOgrenciIlacList[index]),
                    ],
                  ),
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          );
        }),
  );
}

Widget evetHayir({required OgrenciIlacData ilac}) {
  bool evet = false;
  bool hayir = false;

  if (ilac.secenek == "true") {
    evet = true;
  } else if (ilac.secenek == "false") {
    hayir = true;
  } else if (ilac.secenek == "") {
    evet = false;
    hayir = false;
  }
  if (evet == false && hayir == false) {
    return SizedBox(width: 0, height: 0);
  }
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () {},
          child: Text(evet ? "Evet" : "Hayır", style: TextStyle(color: Colors.black)),
        ),
      ]);
}

Future<void> ilacUpdate({required String secenek, required String ilacId}) async {
  Get.context!.loaderOverlay.show();
  Map<String, String> body = {};
  body.addAll({"_id": ilacId});
  body.addAll({"secenek": secenek});
  ModelOgrenciIlacUpdateCevap? ilac = await ogrenciIlacUpdate(
    token: cp.kullanici.token,
    body: body,
  );

  if (ilac == null) {
    toast(msg: hataMesaj);
  } else {
    toast(msg: "İlaç bilgileri güncellendi.");
  }

  Get.context!.loaderOverlay.hide();
}
