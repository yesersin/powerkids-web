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
  for (int i = 0; i < ogun.yemekler.length; i++) {
    list.add(Obx(
      () => OutlinedButton(
        onPressed: () {
          c.yemekSec(yemekAdi: ogun.yemekler[i], ogrenciIndex: ogrenciIndex);
          debugPrint(c.yemekMenuOgrenciSecilen[ogrenciIndex].yemekDurumu());
        },
        child: c.yemekMenuOgrenciSecilen[ogrenciIndex].yemekSecili
                .any((element) => element == ogun.yemekler[i])
            ? Text(ogun.yemekler[i], style: TextStyle(color: Colors.green))
            : Text(ogun.yemekler[i], style: TextStyle(color: Colors.red)),
      ),
    ));
    list.add(SizedBox(width: 10, height: 0));
  }
  list.add(SizedBox(width: 0, height: 20));
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    ),
  );
}
