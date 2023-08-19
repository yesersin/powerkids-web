import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../../../model/web_api/yemek_menu_okul.dart';

Widget yemekList({
  required COgretmen c,
  required int ogrenciIndex,
  required YemekOgun ogun,
}) {
  List<Widget> list = [];
  if (c.yemekMenuOgrenciSecilen[ogrenciIndex].ozelMenu) {
    for (int i = 0; i < c.yemekMenuOgrenciSecilen[ogrenciIndex].yemek.length; i++) {
      list.add(Obx(
        () => TextButton(
          onPressed: () {
            c.yemekSec(
                yemekAdi: c.yemekMenuOgrenciSecilen[ogrenciIndex].yemek[i],
                ogrenciIndex: ogrenciIndex);
          },
          child: c.yemekMenuOgrenciSecilen.value[ogrenciIndex].yemekSecili.any(
                  (element) => element == c.yemekMenuOgrenciSecilen[ogrenciIndex].yemek[i])
              ? Text(c.yemekMenuOgrenciSecilen[ogrenciIndex].yemek[i],
                  style: const TextStyle(color: Colors.black))
              : Text(c.yemekMenuOgrenciSecilen[ogrenciIndex].yemek[i],
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  )),
        ),
      ));
      list.add(SizedBox(width: 2, height: 0));
    }
  } else {
    for (int i = 0; i < ogun.yemekler.length; i++) {
      list.add(Obx(
        () => TextButton(
          onPressed: () {
            c.yemekSec(yemekAdi: ogun.yemekler[i], ogrenciIndex: ogrenciIndex);
          },
          child: c.yemekMenuOgrenciSecilen[ogrenciIndex].yemekSecili
                  .any((element) => element == ogun.yemekler[i])
              ? Text(ogun.yemekler[i], style: const TextStyle(color: Colors.black))
              : Text(ogun.yemekler[i],
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  )),
        ),
      ));
      list.add(SizedBox(width: 2, height: 0));
    }
  }

  list.add(SizedBox(width: 0, height: 10));
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    ),
  );
}
