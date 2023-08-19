import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/mesaj_veli_rehber.dart';
import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_veli_list.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../service/mesaj/mesaj_sinif_veli_list_getir.dart';
import '../../../../static/cprogram.dart';
import '../widget/mesaj_kisi.dart';

Widget rehberList({required COgretmen c}) {
  // if (c.mesajVeliList.isNotEmpty) {
  //   return Obx(() => rehber(c: c));
  // }
  return FutureBuilder(
    future: mesajSinifVeliListGetir(
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      token: cp.kullanici.token,
    ),
    builder: (BuildContext context, AsyncSnapshot<ModelMesajVeliList?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return yukleniyor();
      }
      if (snapshot.data == null) {
        return Text(hataMesaj, style: TextStyle());
      }
      c.mesajVeliList = snapshot.data!.data;
      return Obx(() => rehber(c: c));
    },
  );
}

Widget rehber({required COgretmen c}) {
  List<ModelMesajVeliRehber> list = [];
  for (int i = 0; i < c.mesajVeliList.length; i++) {
    for (int j = 0; j < c.mesajVeliList[i].veliAdSoyad.length; j++) {
      if (c.mesajArananText.value.isEmpty ||
          c.mesajVeliList[i].adSoyad.contains(c.mesajArananText.value) ||
          c.mesajVeliList[i].veliAdSoyad[j].contains(c.mesajArananText.value)) {
        list.add(ModelMesajVeliRehber(
          okulId: c.mesajVeliList[i].okulId,
          adSoyad: c.mesajVeliList[i].adSoyad,
          sinifId: c.mesajVeliList[i].sinifId,
          veliAdSoyad: c.mesajVeliList[i].veliAdSoyad[j],
          veliId: c.mesajVeliList[i].veliId[j],
          veliProfilResim: c.mesajVeliList[i].veliProfilResim[j],
          notificationId: c.mesajVeliList[i].notificationId[j],
        ));
      }
    }
  }
  List<Widget> w = [];
  for (int i = 0; i < list.length; i++) {
    w.add(mesajKisi(
      adSoyad: list[i].veliAdSoyad,
      sonMesaj: list[i].adSoyad,
      veliId: list[i].veliId,
      profilImaj: list[i].veliProfilResim,
      c: c,
    ));
  }
  return SingleChildScrollView(child: Column(children: w));
}
