import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/card/etkinlik_card.dart';
import '../../../../../../static/cogretmen.dart';

Widget ogrenciEtkinlikGecmisListWidget() {
  return Obx(
    () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        shrinkWrap: true,
        itemCount: co.profilOgrenciGecmisEtkinlikList.value.length,
        itemBuilder: (context, index) {
          return GestureDetector(
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
