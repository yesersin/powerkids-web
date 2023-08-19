import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/card/yoklamaCard.dart';
import '../../../../../../static/cogretmen.dart';

Widget ogrenciYoklamaGecmisListWidget() {
  return Obx(
    () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        primary: false,
        shrinkWrap: true,
        itemCount: co.profilOgrenciYoklamaGecmisList.value.length,
        itemBuilder: (context, index) {
          return GestureDetector(
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
