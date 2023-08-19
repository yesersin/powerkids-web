import 'package:flutter/material.dart';

import '../../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../../model/web_api/duyuru/duyuru_gelen.dart';
import '../../../../../static/cprogram.dart';
import '../helper/duyuru_duzenle.dart';

Widget duyuruDuzenleBtn(
    {required int index,
    required ModelDuyuru duyuru,
    required COgretmen c,
    required TextEditingController a,
    required TextEditingController b}) {
  bool result = false;
  if (cp.kullanici.data.yetki.admin) {
    result = true;
  } else if (duyuru.ekleyenId == cp.kullanici.data.id) {
    result = true;
  }

  if (result)
    return IconButton(
        onPressed: () async {
          await duyuruDuzenle(c: c, index: index, a: a, b: b);
        },
        icon: Icon(Icons.edit));
  else
    return SizedBox(width: 0, height: 0);
}
