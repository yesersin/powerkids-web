import 'package:flutter/material.dart';

import '../../../../../const/ogun_tip.dart';
import '../../../../../const/renk.dart';
import '../../../../../model/web_api/yemek_menu_okul.dart';
import 'menu_yemek_oge.dart';

List<Widget> menuYemekler(YemekOgun ogun) {
  List<Widget> list = [];
  for (int i = 0; i < ogun.yemekler.length; i++) {
    list.add(menuYemekOge(
      isim: ogun.yemekler[i],
      renk: Renk.numaraliRenk(i),
      saat: ogun.saat,
      image: Ogun.getOgunAsset(
        ogun.ogun.toString(),
      ),
    ));
  }
  return list;
}
