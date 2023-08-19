import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_ozel_beslenme.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';

import '../../../../../../service/ozel_beslenme/ozel_beslenme_getir.dart';
import '../../../../../../service/ozel_beslenme/ozel_beslenme_update.dart';

Widget ozelBeslenenOgrenci({
  required String yil,
  required String gun,
  required String ay,
  required String ogrenciId,
  required String ogun,
  required int ogrenciIndex,
  required COgretmen c,
}) {
  return FutureBuilder(
    future: ozelBeslenmeGetir(
        yil: yil,
        gun: gun,
        ay: ay,
        token: cp.kullanici.token,
        ogrenciId: ogrenciId,
        ogun: ogun),
    builder: (BuildContext context, AsyncSnapshot<ModelOzelBeslenme?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(width: 0, height: 0);
        return yukleniyor();
      }
      if (snapshot.data == null) {
        return SizedBox(width: 0, height: 0);
      }

      return IconButton(
          onPressed: () {
            ozelBeslenmeUpdate(
              token: cp.kullanici.token,
              body: {"_id": snapshot.data!.data.first.id, "goruldu": "true"},
            );

            Widget w = Column(children: [
              Text("Özel Beslenme", style: TextStyle()),
              Text(snapshot.data!.data.first.yemek.toUpperCase(), style: TextStyle()),
            ]);
            Pencere().ac(content: w, context: context, yukseklik: 150);
          },
          icon: Icon(Icons.info_outline));
    },
  );
}
