import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/mesaj_ogretmen_rehber.dart';
import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_ogretmen_list.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../service/mesaj/mesaj_sinif_ogretmen_list_getir.dart';
import '../../../../static/cprogram.dart';
import '../widget/mesaj_kisi.dart';

Widget ogretmenList({required COgretmen c}) {
  if (c.mesajOgretmenList.isNotEmpty) {
    return ogretmenler(c: c);
  }
  return FutureBuilder(
    future: mesajSinifOgretmenListGetir(
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      token: cp.kullanici.token,
    ),
    builder: (BuildContext context, AsyncSnapshot<ModelMesajOgretmenList?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return yukleniyor();
      }
      if (snapshot.data == null) {
        return Text(hataMesaj, style: TextStyle());
      }
      c.mesajOgretmenList = snapshot.data!.data;
      return ogretmenler(c: c);
    },
  );
}

Widget ogretmenler({required COgretmen c}) {
  List<ModelMesajOgretmenRehber> list = [];
  for (int i = 0; i < c.mesajOgretmenList.length; i++) {
    list.add(ModelMesajOgretmenRehber(
      id: c.mesajOgretmenList[i].id,
      notificationId: c.mesajOgretmenList[i].notificationId,
      adSoyad: c.mesajOgretmenList[i].adSoyad,
      fotografUrl: c.mesajOgretmenList[i].fotografUrl,
    ));
  }
  List<Widget> w = [];
  for (int i = 0; i < list.length; i++) {
    w.add(mesajKisi(
        adSoyad: list[i].adSoyad,
        sonMesaj: "",
        veliId: list[i].id,
        profilImaj: list[i].fotografUrl,
        c: c,
        ogretmenList: true));
  }
  return SingleChildScrollView(child: Column(children: w));
}
