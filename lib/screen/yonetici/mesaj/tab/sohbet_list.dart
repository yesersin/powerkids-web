import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/model/mesaj_sohbet.dart';
import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_sohbet_list.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../service/mesaj/mesaj_sinif_sohbet_list_getir.dart';
import '../../../../static/cprogram.dart';
import '../widget/mesaj_kisi.dart';

Widget sohbetList({required COgretmen c, String? ogretmenId}) {
  //öğretmenId admin ekranından gönderilir. eğer boşsa öğretmen kendi mesajlarına
  // //bakıyordur.
  // if (c.mesajSohbetList.isNotEmpty) {
  //   return sohbet(c: c);
  // }
  return FutureBuilder(
    future: mesajSinifSohbetListGetir(
      okulId: cp.okul!.data.id,
      id: ogretmenId ?? cp.kullanici.data.id,
      token: cp.kullanici.token,
      yetki: yetkiText,
    ),
    builder: (BuildContext context, AsyncSnapshot<ModelMesajSohbetList?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return yukleniyor();
      }
      if (snapshot.data == null) {
        return Text(hataMesaj, style: TextStyle());
      }
      c.mesajSohbetList = snapshot.data!.data;
      return sohbet(c: c);
    },
  );
}

Widget sohbet({required COgretmen c}) {
  List<ModelMesajSohbet> list = [];
  for (int i = 0; i < c.mesajSohbetList.length; i++) {
    list.add(
      ModelMesajSohbet(
        adSoyad: c.mesajSohbetList[i].veliId.adSoyad,
        id: c.mesajSohbetList[i].veliId.id,
        profilResim: c.mesajSohbetList[i].veliId.fotografUrl,
        notificationId: c.mesajSohbetList[i].veliId.notificationId,
        guncelleme: c.mesajSohbetList[i].guncellemeZamani,
        okunmayan: c.mesajSohbetList[i].oOkunmayan.toString(),
        sonMesaj: c.mesajSohbetList[i].sonMesaj.toString(),
      ),
    );
  }
  List<Widget> w = [];
  for (int i = 0; i < list.length; i++) {
    w.add(
      mesajKisi(
        adSoyad: list[i].adSoyad,
        sonMesaj: list[i].sonMesaj,
        veliId: list[i].id,
        profilImaj: list[i].profilResim,
        saat: Tarih().sonMesajSaat(tarih: c.mesajSohbetList[i].guncellemeZamani),
        bildirim: c.mesajSohbetList[i].oOkunmayan.toString(),
        c: c,
      ),
    );
  }
  return SingleChildScrollView(child: Column(children: w));
}
