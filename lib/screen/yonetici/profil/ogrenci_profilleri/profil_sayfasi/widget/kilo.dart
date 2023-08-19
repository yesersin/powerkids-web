import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/screen/ogretmen/profil/ogrenci_profilleri/profil_sayfasi/widget/yuvarlak.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../../const/renk.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_karti.dart';

Widget kilo({required ModelOgrenciKarti kart}) {
  return yuvarlak(
      sayi: kart.data.boykilo.last.kilo.toString(),
      altMetin: "Kilo",
      renk: Renk.maviAcik,
      komut: () {
        Pencere().ac(
            baslik: "Boy-Kilo Geçmişi",
            content: Column(
                children: kart.data.boykilo
                    .map(
                      (e) => Row(children: [
                        Text(Tarih().gunAyYil(e.tarih), style: TextStyle()),
                        Spacer(),
                        Text(e.boy.toString(), style: TextStyle()),
                        Spacer(),
                        Text(e.kilo.toString(), style: TextStyle()),
                      ]),
                    )
                    .toList()),
            context: Get.context!);
      });
}
