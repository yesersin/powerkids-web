import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/yemek/ogun_ayrinti/widget/veli_notu_olan_ogrenci.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/yemek/ogun_ayrinti/widget/yemek_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../const/yoklama_tip.dart';
import '../../../../../../model/ogrenci_yemek_secimi.dart';
import '../../../../../../model/web_api/yemek_menu_okul.dart';
import '../../../../../../model/web_api/yoklama/yoklama.dart';
import 'ogrenci_adi.dart';
import 'ogrenci_adi_gelmeyen.dart';
import 'ozel_beslenen_ogrenci.dart';

Widget yemekOgrenciList(
    {required COgretmen c, required YemekOgun ogun, ModelYoklama? yoklama}) {
  c.yemekMenuOgrenciSecilen.value = List.generate(
      c.ogrenciList.value!.data.length,
      (index) => ModelOgrenciYemekSecimi(
          ogrenciId: c.ogrenciList.value!.data[index].id,
          yemek: ogun.yemekler,
          ogrenci: c.ogrenciList.value!.data[index]));

  if (yoklama != null) {
    debugPrint("yoklama var");
    for (int i = 0; i < yoklama.data.length; i++) {
      int ogrenciIndex = c.ogrenciList.value!.data
          .indexWhere((element) => element.id == yoklama.data[i].ogrenciId.id);
      if (yoklama.data[i].tip.toString() == YoklamaTip.okula_gelmedi ||
          yoklama.data[i].tip.toString() == YoklamaTip.beklemede) {
        if (ogrenciIndex != -1) {
          // debugPrint("----------");
          // debugPrint("öğrenci:" + yoklama!.data[i].ogrenciId.id);
          // debugPrint("öğrenci:" + yoklama!.data[i].ogrenciId.adSoyad);
          // debugPrint("öğrenci:" + yoklama!.data[i].tip.toString());
          // debugPrint("----------");
          c.yemekMenuOgrenciSecilen[ogrenciIndex].gelmedi = true;
        }
      }
    }
    //gelmeyenleri sona at
    for (int i = 0; i < c.yemekMenuOgrenciSecilen.length; i++) {
      if (c.yemekMenuOgrenciSecilen[i].gelmedi) {
        c.yemekMenuOgrenciSecilen.add(c.yemekMenuOgrenciSecilen.removeAt(i));
        c.ogrenciList.value!.data.add(c.ogrenciList.value!.data.removeAt(i));
      }
    }
  } else {
    debugPrint("yoklama yok");
  }
  List<Widget> list = [];

  list.add(SizedBox(width: Get.width, height: 20));
  for (int i = 0; i < c.ogrenciList.value!.data.length; i++) {
    debugPrint(c.ogrenciList.value!.data[i].id);
    if (c.yemekMenuOgrenciSecilen[i].gelmedi) {
      list.add(ogrenciAdiGelmeyen(i, c.ogrenciList.value!.data[i]));
      list.add(SizedBox(width: 0, height: 20));
      continue;
    }
    list.add(Row(
      children: [
        ogrenciAdi(i, c.ogrenciList.value!.data[i]),
        SizedBox(width: 20, height: 0),
        ozelBeslenenOgrenci(
          ogrenciId: c.ogrenciList.value!.data[i].id,
          ogun: ogun.ogun.toString(),
          ay: Tarih.ayDate(c.yemekSecilenTarih.value),
          gun: Tarih.gunDate(c.yemekSecilenTarih.value),
          yil: Tarih.yilDate(c.yemekSecilenTarih.value),
          ogrenciIndex: i,
          c: c,
        ),
        veliNotuOlanOgrenci(
          ogrenciId: c.ogrenciList.value!.data[i].id,
          ogun: ogun.ogun.toString(),
          ay: Tarih.ayDate(c.yemekSecilenTarih.value),
          gun: Tarih.gunDate(c.yemekSecilenTarih.value),
          yil: Tarih.yilDate(c.yemekSecilenTarih.value),
        ),
      ],
    ));
    list.add(SizedBox(width: 0, height: 20));
    list.add(yemekList(ogrenciIndex: i, c: c, ogun: ogun));
    list.add(SizedBox(width: 0, height: 20));
  }
  list.add(SizedBox(width: 0, height: 20));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: list,
  );
}
