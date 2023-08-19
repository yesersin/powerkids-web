import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/web_api/ogrenci/ogrenci_karti.dart';

Widget ogrenciPsikologRaporListWidget({required ModelOgrenciKarti kart}) {
  return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5),
      primary: false,
      shrinkWrap: true,
      itemCount: kart.data.psikolog.length,
      itemBuilder: (context, index) {
        if (kart.data.psikolog[index].veliGorsunmu == false)
          return SizedBox(width: 0, height: 0);
        return Column(
          children: [
            baslik(
              baslikMetin: kart.data.psikolog[index].gorusmeKonusu,
              psikologTarih: kart.data.psikolog[index].gorusmeTarihi,
            ),
            aciklama(
              metin: kart.data.psikolog[index].sonuc,
              isBirligi: kart.data.psikolog[index].isBirligi,
            ),
            SizedBox(width: 0, height: 10),
          ],
        );
      });
}

Widget baslik({required String baslikMetin, required DateTime psikologTarih}) {
  return Container(
    padding: EdgeInsets.all(10),
    width: Get.width - 10,
    decoration: BoxDecoration(color: Renk.maviAcik, borderRadius: BorderRadius.circular(16)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: tarih(psikologTarih: psikologTarih)),
        Expanded(
          flex: 3,
          child: Text(
            baslikMetin,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget tarih({required DateTime psikologTarih}) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(Tarih().gunAyYil(psikologTarih), style: TextStyle(color: Colors.white)),
    ]),
  );
}

Widget aciklama({required String metin, required String isBirligi}) {
  String bulunamadi = "Rapor bulunamadı!";
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: Get.width - 10,
        height: 150,
        decoration: BoxDecoration(color: Renk.yesil, borderRadius: BorderRadius.circular(0)),
        child: SingleChildScrollView(
          child: Text(
            metin == "" ? bulunamadi : metin,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      if (isBirligi != "")
        Positioned(
            right: 10,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(16)),
              child: Text("İş birliği:" + isBirligi, style: TextStyle(color: Colors.white)),
            ))
    ],
  );
}
