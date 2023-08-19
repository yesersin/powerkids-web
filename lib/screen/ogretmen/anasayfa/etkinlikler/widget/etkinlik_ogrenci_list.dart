import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/const/etkinlik_tip.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/web_api/etkinlik.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../../../../const/yoklama_tip.dart';
import '../../../../../model/etkinlik_ekle.dart';
import '../../../../../model/web_api/yoklama/yoklama.dart';
import '../../../../../static/cogretmen.dart';
import '../../yemek/ogun_ayrinti/widget/ogrenci_adi.dart';
import '../../yemek/ogun_ayrinti/widget/ogrenci_adi_gelmeyen.dart';

Widget etkinlikOgrenciList(
    {required COgretmen c, ModelYoklama? yoklama, required Etkinlik etkinlik}) {
  if (yoklama != null) {
    debugPrint("yoklama var");
    for (int i = 0; i < yoklama.data.length; i++) {
      int ogrenciIndex = c.ogrenciList.value!.data
          .indexWhere((element) => element.id == yoklama.data[i].ogrenciId.id);
      if (yoklama.data[i].tip.toString() == YoklamaTip.okula_gelmedi ||
          yoklama.data[i].tip.toString() == YoklamaTip.beklemede) {
        if (ogrenciIndex != -1) {
          c.etkinliklerOgrenciSecilen[ogrenciIndex].gelmedi = true;
        }
      }
    }
    //gelmeyenleri sona at
    for (int i = 0; i < c.etkinliklerOgrenciSecilen.length; i++) {
      if (c.etkinliklerOgrenciSecilen[i].gelmedi) {
        c.etkinliklerOgrenciSecilen.add(c.etkinliklerOgrenciSecilen.removeAt(i));
        c.ogrenciList.value!.data.add(c.ogrenciList.value!.data.removeAt(i));
      }
    }
  } else {
    debugPrint("yoklama yok");
  }
  List<Widget> list = [];
  list.add(SizedBox(width: Get.width, height: 0));
  list.add(SizedBox(width: Get.width, height: 20));
  int kopyalaEklendi = 0;

  for (int i = 0; i < c.etkinliklerOgrenciSecilen.length; i++) {
    // debugPrint(c.ogrenciList.value!.data[i].id);
    if (c.etkinliklerOgrenciSecilen[i].gelmedi) {
      list.add(GestureDetector(
          onTap: () {
            // debugPrint("değişti");
            debugPrint(c.etkinliklerOgrenciSecilen[i].beklemede.toString());
            c.etkinliklerOgrenciSecilen[i].beklemede =
                !c.etkinliklerOgrenciSecilen[i].beklemede;
            c.etkinliklerOgrenciSecilen.refresh();
          },
          child: ogrenciAdiGelmeyen(i, c.etkinliklerOgrenciSecilen[i].ogrenci, true)));
      list.add(SizedBox(width: Get.width, height: 20));
      continue;
    }
    if (c.etkinliklerOgrenciSecilen[i].beklemede) {
      list.add(GestureDetector(
          onTap: () {
            // debugPrint("değişti");
            debugPrint(c.etkinliklerOgrenciSecilen[i].beklemede.toString());
            c.etkinliklerOgrenciSecilen[i].beklemede =
                !c.etkinliklerOgrenciSecilen[i].beklemede;
            c.etkinliklerOgrenciSecilen.refresh();
          },
          child: ogrenciAdiGelmeyen(i, c.etkinliklerOgrenciSecilen[i].ogrenci, true)));
      list.add(SizedBox(width: Get.width, height: 20));
      continue;
    }
    kopyalaEklendi = kopyalaEklendi + 1; //input için ilk öğrenciye kopyala ekle
    list.add(Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  c.etkinliklerOgrenciSecilen[i].beklemede =
                      !c.etkinliklerOgrenciSecilen[i].beklemede;
                  c.etkinliklerOgrenciSecilen.refresh();
                },
                child: ogrenciAdi(i, c.etkinliklerOgrenciSecilen[i].ogrenci, true)),
            SizedBox(width: 0, height: 45),
          ],
        ),
        if (etkinlik.tip == "input" && kopyalaEklendi < 2)
          Positioned(
            right: 0,
            top: 0,
            child: OutlinedButton(
                // color: Colors.red,
                onPressed: () {
                  String temp = c.etkinliklerOgrenciSecilen[0].textController.text;
                  for (int i = 0; i < c.etkinliklerOgrenciSecilen.length; i++) {
                    c.etkinliklerOgrenciSecilen[i].textController.text = temp;
                  }
                },
                child: Icon(Icons.copy, size: 18)),
          )
      ],
    ));
    list.add(SizedBox(width: 0, height: 10));
    if (etkinlik.tip == EtkinlikTip.secenek) {
      list.add(
        etkinlikSecenek(
          etkinlik: etkinlik,
          controller: c.etkinliklerOgrenciSecilen[i].controller,
          ogrenci: c.etkinliklerOgrenciSecilen[i],
          index: i,
        ),
      );
    } else if (etkinlik.tip == EtkinlikTip.input) {
      list.add(etkinlikText(
          etkinlik: etkinlik, controller: c.etkinliklerOgrenciSecilen[i].textController));
    }
    list.add(SizedBox(width: 0, height: 20));
  }
  // list.add(SizedBox(width: 0, height: 20));

  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: list,
  );
}

Widget etkinlikSecenek({
  required Etkinlik etkinlik,
  required GroupButtonController controller,
  required ModelEtkinlikEkleOgrenci ogrenci,
  required int index,
}) {
  List<String> secenekler = [];
  if (etkinlik.secenekBir != "") {
    secenekler.add(etkinlik.secenekBir);
  }
  if (etkinlik.secenekIki != "") {
    secenekler.add(etkinlik.secenekIki);
  }
  if (etkinlik.secenekUc != "") {
    secenekler.add(etkinlik.secenekUc);
  }
  if (etkinlik.secenekDort != "") {
    secenekler.add(etkinlik.secenekDort);
  }

  if (etkinlik.seciliSecenek == etkinlik.secenekBir) {
    controller.selectIndex(0);
  } else if (etkinlik.seciliSecenek == etkinlik.secenekIki) {
    controller.selectIndex(1);
  } else if (etkinlik.seciliSecenek == etkinlik.secenekUc) {
    controller.selectIndex(2);
  } else if (etkinlik.seciliSecenek == etkinlik.secenekDort) {
    controller.selectIndex(3);
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: GroupButton(
      buttons: secenekler,
      controller: controller,
      options: GroupButtonOptions(
          selectedTextStyle: TextStyle(fontSize: 10, color: Colors.white),
          unselectedTextStyle: TextStyle(fontSize: 10, color: Colors.black),
          runSpacing: 0,
          spacing: 0,
          textPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
      onSelected: (text, index, value) {
        ogrenci.tercih = text.toString();
        co.etkinliklerOgrenciSecilen[index].tercih = text.toString();
        debugPrint(ogrenci.tercih);
      },
    ),
  );
}

Widget etkinlikText({required Etkinlik etkinlik, required TextEditingController controller}) {
  return Textfield().text(
    controller: controller,
    minLines: 3,
    maxLines: 5,
    textRenk: Colors.black,
    onSubmit: (text) {},
  );
}
