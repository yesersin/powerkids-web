import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_dogum_gunu_olanlari_getir.dart';
import 'package:com.powerkidsx/service/kullanici/kullanici_dogum_gunu_getir.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/renk.dart';

void dogumGunuKontrolKullanici() async {
  debugPrint("doğum günü kontrol");
  ModelDogumGunuKullanici? list =
      await getDogumGunuKullanici(okulId: cp.okul!.data.id, token: cp.kullanici.token);
  if (list == null || list.data.isEmpty) return;

  String result = await Shared().get(
    key: list.data.first.dogumTarihi.toString(),
  );
  if (result == "") {
    debugPrint("kaydet");
    await Shared().save(
      key: list.data.first.dogumTarihi.toString(),
      value: list.data.first.dogumTarihi.toString(),
    );
  } else {
    //daha önce gösterilmiş
    return;
  }

  Pencere().ac(
    content: dogumList(
        list: list.data.map((e) => e.adSoyad).toList(),
        list2: list.data.map((x) => x.yetki).toList()),
    context: Get.context!,
    baslik: "Doğum Günü",
  );
}

Widget dogumList({required List<String> list, required List<Yetki> list2}) {
  List<Widget> wList = [];
  for (int i = 0; i < list.length; i++) {
    if (list2[i].veli)
      wList.add(bugunDogan(isim: list[i] + " - Veli", renk: Renk.numaraliRenk(i)));
    else
      wList.add(bugunDogan(isim: list[i] + " - Öğr.", renk: Renk.numaraliRenk(i)));

    wList.add(Divider(height: 2));
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: wList,
  );
}

Widget bugunDogan({required String isim, required Color renk}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
          padding: EdgeInsets.only(right: 5.0, bottom: 5.0), // 5px sağ boşluk
          child: Icon(Icons.cake, color: renk)),
      SizedBox(width: 10), // 10 birim genişlik boşluğu
      Expanded(child: Text(isim, style: TextStyle(color: renk))),
    ],
  );
}
