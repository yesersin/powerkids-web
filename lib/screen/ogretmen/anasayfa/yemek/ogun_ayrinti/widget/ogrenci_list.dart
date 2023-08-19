import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/yemek/ogun_ayrinti/widget/veli_notu_olan_ogrenci.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/yemek/ogun_ayrinti/widget/yemek_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../const/yoklama_tip.dart';
import '../../../../../../model/ogrenci_yemek_secimi.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_ozel_beslenme.dart';
import '../../../../../../model/web_api/yemek_menu_okul.dart';
import '../../../../../../model/web_api/yoklama/yoklama.dart';
import '../../../../../../service/ozel_beslenme/ozel_beslenme_getir.dart';
import '../../../../../../service/ozel_beslenme/ozel_beslenme_update.dart';
import '../../../../../../static/cprogram.dart';
import 'ogrenci_adi.dart';
import 'ogrenci_adi_gelmeyen.dart';
import 'ozel_beslenen_ogrenci.dart';

Future<Widget> yemekOgrenciList(
    {required COgretmen c, required YemekOgun ogun, ModelYoklama? yoklama}) async {
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
          c.yemekMenuOgrenciSecilen[ogrenciIndex].gelmedi = true;
        }
      }
    }
    //gelmeyenleri sona at
    for (int i = 0; i < c.yemekMenuOgrenciSecilen.length; i++) {
      if (c.yemekMenuOgrenciSecilen[i].gelmedi || c.yemekMenuOgrenciBeklemede[i]) {
        c.yemekMenuOgrenciSecilen.add(c.yemekMenuOgrenciSecilen.removeAt(i));
        // c.ogrenciList.value!.data.add(c.ogrenciList.value!.data.removeAt(i));
      }
    }
  } else {
    debugPrint("yoklama yok");
  }

  //özel beslenme getir
  for (int i = 0; i < c.yemekMenuOgrenciSecilen.length; i++) {
    ModelOzelBeslenme? o = await ozelBeslenmeGetir(
      yil: c.yemekSecilenTarih.value.year.toString(),
      gun: c.yemekSecilenTarih.value.day.toString(),
      ay: c.yemekSecilenTarih.value.month.toString(),
      token: cp.kullanici.token,
      ogrenciId: c.yemekMenuOgrenciSecilen[i].ogrenciId,
      ogun: ogun.ogun.toString(),
    );
    if (o != null) {
      c.yemekMenuOgrenciSecilen[i].ozelMenu = true;
      c.yemekMenuOgrenciSecilen[i].ozelMenuList = o.data.first.yemek.split(',');
      c.yemekMenuOgrenciSecilen[i].yemekSecili = o.data.first.yemek.split(',');
      c.yemekMenuOgrenciSecilen[i].yemek = o.data.first.yemek.split(',');
      ozelBeslenmeUpdate(
        token: cp.kullanici.token,
        body: {"_id": o.data.first.id, "goruldu": "true"},
      );
    }
  }
  //özel beslenme getir

  List<Widget> list = [];
  list.add(SizedBox(width: Get.width, height: 20));
  for (int i = 0; i < c.yemekMenuOgrenciSecilen.length; i++) {
    if (c.yemekMenuOgrenciSecilen[i].gelmedi) {
      list.add(ogrenciAdiGelmeyen(i, c.yemekMenuOgrenciSecilen[i].ogrenci, false));
      list.add(const SizedBox(width: 0, height: 20));
      continue;
    }
    list.add(Obx(
      () => c.yemekMenuOgrenciBeklemede[i]
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ogrenciAdiGelmeyen(i, c.yemekMenuOgrenciSecilen[i].ogrenci, false),
                const SizedBox(width: 20, height: 0),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ogrenciAdi(i, c.yemekMenuOgrenciSecilen[i].ogrenci, false),
                const SizedBox(width: 20, height: 0),
                ozelBeslenenOgrenci(
                  ogrenciId: c.yemekMenuOgrenciSecilen[i].ogrenci.id,
                  ogun: ogun.ogun.toString(),
                  ay: Tarih.ayDate(c.yemekSecilenTarih.value),
                  gun: Tarih.gunDate(c.yemekSecilenTarih.value),
                  yil: Tarih.yilDate(c.yemekSecilenTarih.value),
                  ogrenciIndex: i,
                  c: c,
                ),
                if (c.yemekMenuOgrenciBeklemede[i] == false)
                  veliNotuOlanOgrenci(
                    ogrenciId: c.yemekMenuOgrenciSecilen[i].ogrenci.id,
                    ogun: ogun.ogun.toString(),
                    ay: Tarih.ayDate(c.yemekSecilenTarih.value),
                    gun: Tarih.gunDate(c.yemekSecilenTarih.value),
                    yil: Tarih.yilDate(c.yemekSecilenTarih.value),
                  ),
              ],
            ),
    ));
    list.add(SizedBox(width: 0, height: 20));

    list.add(Obx(() => c.yemekMenuOgrenciBeklemede[i]
        ? SizedBox()
        : yemekList(ogrenciIndex: i, c: c, ogun: ogun)));
    list.add(SizedBox(width: 0, height: 20));
  }
  list.add(SizedBox(width: 0, height: 20));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: list,
  );
}
