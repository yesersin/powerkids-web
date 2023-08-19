import 'package:flutter/material.dart';

import '../../../../../../component/custom/button.dart';
import '../../../../../../const/renk.dart';
import '../../../../../../model/web_api/sinif_ogrencileri.dart';
import '../../../../../../static/cogretmen.dart';

Widget ogrenciAdiGelmeyen(int index, ModelOgrenci ogrenci, bool etkinlik) {
  return Buton().mavi(
      click: () {
        if (etkinlik) {
          if (co.etkinliklerOgrenciSecilen[index].gelmedi) {
            //öğrenci gelmediyse işlem yaptırma
            return;
          }
          co.etkinliklerOgrenciSecilen[index].beklemede =
              !co.etkinliklerOgrenciSecilen[index].beklemede;
          co.etkinliklerOgrenciSecilen.refresh();
          return;
        }
        debugPrint("index:$index " + co.yemekMenuOgrenciBeklemede[index].toString());
        co.yemekMenuOgrenciBeklemede[index] = !co.yemekMenuOgrenciBeklemede[index];
        co.yemekMenuOgrenciSecilen.refresh();
        co.yemekMenuOgrenciBeklemede.refresh();
      },
      renk: Renk.griMetin,
      text: ogrenci.adSoyad,
      height: 30);
}
