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
          return GestureDetector(
            onLongPress: () async {},
            child: Column(
              children: [
                etkinlikCard(
                  saat: Tarih().saatDk(co.profilOgrenciIlacList[index].createdAt),
                  baslik: co.profilOgrenciIlacList[index].ilacAdi,
                  mesaj: co.profilOgrenciIlacList[index].mesaj,
                  ogretmenAd: co.profilOgrenciIlacList[index].ogretmenAdSoyad,
                  renk: Renk.numaraliRenk(index),
                ),
                evetHayir(ilac: co.profilOgrenciIlacList[index]),
                SizedBox(width: 0, height: 10),
              ],
            ),
          );
        }),
  );
}

Widget evetHayir({required OgrenciIlacData ilac}) {
  Get.context!.loaderOverlay.hide();
  if (ilac.tip != 1) {
    return Text("", style: TextStyle());
  }
  if (ilac.secenek == "") {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
              onPressed: () {
                ilacUpdate(secenek: "true", ilacId: ilac.id);
              },
              child: Text("Evet")),
          SizedBox(width: 10, height: 0),
          MaterialButton(
              onPressed: () {
                ilacUpdate(secenek: "false", ilacId: ilac.id);
              },
              child: Text("Hayır")),
        ]);
  }
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
            color: ilac.secenek == "true" ? Colors.green : Colors.grey,
            onPressed: () {
              toast(msg: "Daha önce seçildi.");
            },
            child: Text("Evet")),
        SizedBox(width: 10, height: 0),
        MaterialButton(
            color: ilac.secenek == "true" ? Colors.grey : Colors.green,
            onPressed: () {
              toast(msg: "Daha önce seçildi.");
            },
            child: Text("Hayır")),
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
