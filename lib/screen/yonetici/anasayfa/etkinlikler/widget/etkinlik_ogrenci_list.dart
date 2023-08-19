import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/web_api/etkinlik.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../../../../const/yoklama_tip.dart';
import '../../../../../model/etkinlik_ekle.dart';
import '../../../../../model/web_api/yoklama/yoklama.dart';
import '../../../../ogretmen/anasayfa/yemek/ogun_ayrinti/widget/ogrenci_adi.dart';
import '../../../../ogretmen/anasayfa/yemek/ogun_ayrinti/widget/ogrenci_adi_gelmeyen.dart';

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
          // debugPrint("----------");
          // debugPrint("öğrenci:" + yoklama!.data[i].ogrenciId.id);
          // debugPrint("öğrenci:" + yoklama!.data[i].ogrenciId.adSoyad);
          // debugPrint("öğrenci:" + yoklama!.data[i].tip.toString());
          // debugPrint("----------");
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
  list.add(MaterialButton(
      color: Colors.red,
      onPressed: () {
        for (int i = 0; i < c.etkinliklerOgrenciSecilen.length; i++) {
          c.etkinliklerOgrenciSecilen[i].textController.text = "bla bla";
        }
      },
      child: Text("Kopyala")));
  list.add(SizedBox(width: Get.width, height: 20));
  for (int i = 0; i < c.ogrenciList.value!.data.length; i++) {
    debugPrint(c.ogrenciList.value!.data[i].id);
    if (c.etkinliklerOgrenciSecilen[i].gelmedi || c.etkinliklerOgrenciSecilen[i].beklemede) {
      list.add(GestureDetector(
          onTap: () {
            debugPrint("değişti");
            debugPrint(c.etkinliklerOgrenciSecilen[i].beklemede.toString());
            c.etkinliklerOgrenciSecilen[i].beklemede =
                !c.etkinliklerOgrenciSecilen[i].beklemede;
            c.etkinliklerOgrenciSecilen.refresh();
          },
          child: ogrenciAdiGelmeyen(i, c.ogrenciList.value!.data[i], true)));
      // list.add(SizedBox(width: 0, height: 20));
      continue;
    }
    list.add(Row(
      children: [
        GestureDetector(
            onTap: () {
              debugPrint("değişti");
              debugPrint(c.etkinliklerOgrenciSecilen[i].beklemede.toString());
              c.etkinliklerOgrenciSecilen[i].beklemede =
                  !c.etkinliklerOgrenciSecilen[i].beklemede;
              c.etkinliklerOgrenciSecilen.refresh();
            },
            child: ogrenciAdi(i, c.ogrenciList.value!.data[i], true)),
      ],
    ));
    list.add(SizedBox(width: 0, height: 10));
    if (etkinlik.tip == "secenek") {
      list.add(etkinlikSecenek(
          etkinlik: etkinlik,
          controller: c.etkinliklerOgrenciSecilen[i].controller,
          ogrenci: c.etkinliklerOgrenciSecilen[i]));
    } else if (etkinlik.tip == "input") {
      list.add(etkinlikText(
          etkinlik: etkinlik, controller: c.etkinliklerOgrenciSecilen[i].textController));
    }
    list.add(SizedBox(width: 0, height: 20));
  }
  // list.add(SizedBox(width: 0, height: 20));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: list,
  );
}

Widget etkinlikSecenek(
    {required Etkinlik etkinlik,
    required GroupButtonController controller,
    required ModelEtkinlikEkleOgrenci ogrenci}) {
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
      onSelected: (text, index, value) {
        ogrenci.tercih = text.toString();
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
