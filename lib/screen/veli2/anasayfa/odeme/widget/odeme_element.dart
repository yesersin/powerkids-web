import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/const/odeme_tip.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/renk.dart';
import '../../../../../model/web_api/veli/veli_borc.dart';
import '../../../../../static/cprogram.dart';

Widget odemeElement({required VeliBorcData data, required int index}) {
  late Color renk;
  int fark = data.vadeTarihi.difference(DateTime.now()).inDays;
  debugPrint(data.vadeTarihi.toString() + " fark:" + fark.toString());
  if (data.odemeTipi != -1) {
    renk = Renk.odemeYesil;
  } else if (fark >= 0) {
    renk = Renk.odemeSari;
  } else {
    renk = Renk.kirmizi;
  }
  double size = 20;
  var shadow = <Shadow>[
    Shadow(
      offset: Offset(0.0, 1.0),
      blurRadius: 10.0,
      color: Color.fromARGB(150, 0, 0, 0),
    ),
  ];
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.circular(16)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(width: Get.width * 0.85, height: 30),
          _tutar(size, shadow, data),
          SizedBox(width: 0, height: 10),
          _durum(size, shadow, data),
          SizedBox(width: 0, height: 10),
          _vadeTarihi(size, shadow, data),
          SizedBox(width: 0, height: 30),
        ]),
      ),
      if (cp.okulAyarlar.data.odemeIzni && data.link && data.odemeTipi == OdemeTip.odenmedi)
        _odemeYapBtn(data),
      _aciklamaBtn(data)
    ],
  );
}

Positioned _aciklamaBtn(VeliBorcData data) {
  return Positioned(
    left: 5,
    top: 0,
    child: Buton().mavi(
        renk: Renk.odemeMavi,
        click: () {
          Pencere().ac(
              content: Text(data.aciklama, style: TextStyle()),
              context: Get.context!,
              baslik: data.hizmetAdi,
              yukseklik: 150);
        },
        text: data.hizmetAdi),
    width: Get.width * 0.35,
  );
}

Positioned _odemeYapBtn(VeliBorcData data) {
  return Positioned(
    right: 5,
    bottom: 0,
    child: Buton().mavi(
        renk: Renk.odemeMavi,
        click: () {
          urlAc(url: data.url);
        },
        text: "Ödeme Yap"),
    width: Get.width * 0.30,
  );
}

Row _vadeTarihi(double size, List<Shadow> shadow, VeliBorcData data) {
  return Row(
    children: [
      Expanded(
          child: Text("Vade Tarihi",
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
      Expanded(
          child: Text(":" + Tarih().gunAyYil(data.vadeTarihi),
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
    ],
  );
}

Row _durum(double size, List<Shadow> shadow, VeliBorcData data) {
  return Row(
    children: [
      Expanded(
          child: Text("Durum",
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
      Expanded(
          child: Text(":" + OdemeTip.getOdemeText(data.odemeTipi),
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
    ],
  );
}

Row _tutar(double size, List<Shadow> shadow, VeliBorcData data) {
  return Row(
    children: [
      Expanded(
          child: Text("Tutar",
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
      Expanded(
          child: Text(":" + data.taksitTutari.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: size,
                shadows: shadow,
              ))),
    ],
  );
}
