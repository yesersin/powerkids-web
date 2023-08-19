import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';

import '../../../../../../model/web_api/veli/veli_yemek_not.dart';
import '../../../../../../model/web_api/veli/veli_yemek_not_update_cevap.dart';
import '../../../../../../service/veli/veli_yemek_not_getir.dart';
import '../../../../../../service/veli/veli_yemek_not_update.dart';

Widget veliNotuOlanOgrenci({
  required String yil,
  required String gun,
  required String ay,
  required String ogrenciId,
  required String ogun,
}) {
  return FutureBuilder(
    future: veliYemekNotGetir(
        yil: yil,
        gun: gun,
        ay: ay,
        token: cp.kullanici.token,
        ogrenciId: ogrenciId,
        ogun: ogun),
    builder: (BuildContext context, AsyncSnapshot<ModelVeliYemekNot?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(width: 0, height: 0);
        return yukleniyor();
      }
      if (snapshot.data == null) {
        return SizedBox(width: 0, height: 0);
      }
      return IconButton(
          onPressed: () async {
            ModelVeliYemekNotUpdateCevap? cevap = await veliYemekNotUpdate(
              token: cp.kullanici.token,
              body: {"_id": snapshot.data!.data.first.id, "goruldu": "true"},
            );
            if (cevap == null) {
              toast(msg: hataMesaj);
            }
            Widget w = Column(children: [
              Text("Veli'nin Notu", style: TextStyle()),
              Text(snapshot.data!.data.first.not, style: TextStyle()),
            ]);
            Pencere().ac(content: w, context: context, yukseklik: 150);
          },
          icon: Icon(
            Icons.info_outline,
            color: Colors.red,
          ));
    },
  );
}
