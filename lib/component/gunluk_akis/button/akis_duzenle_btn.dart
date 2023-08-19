import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../const/yetki_text.dart';
import '../../../model/web_api/gunluk_akis.dart';
import '../../../screen/ogretmen/anasayfa/gunluk_akis/helper/gunluk_akis_duzenle.dart';
import '../../../static/cprogram.dart';
import '../../../static/yetki.dart';

Widget akisDuzenleBtn(
    {required int index, required GunlukAkisData akis, required COgretmen c}) {
  if (yetkiText == YetkiText.veli) {
    //yetki veli ise gösterme
    return SizedBox(width: 0, height: 0);
  }
  bool result = false;
  if (cp.kullanici.data.yetki.admin) {
    result = true;
  } else if (akis.ekleyenId == cp.kullanici.data.id) {
    result = true;
  }

  if (result)
    return IconButton(
        onPressed: () async {
          await gunlukAkisDuzenle(c: c, index: index);
        },
        icon: Icon(Icons.edit));
  else
    return SizedBox(width: 0, height: 0);
}
