import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../const/renk.dart';
import '../../../const/yetki_text.dart';
import '../../../model/web_api/gunluk_akis.dart';
import '../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../static/cprogram.dart';
import '../../pencere/uyari_pencere.dart';

Widget akisGorulduBtn(GunlukAkisData akis) {
  // akis.gordu = ["gördü1", "gördü2"]; //geçici
  if (yetkiText == YetkiText.veli) {
    //yetki veli ise gösterme
    return SizedBox(width: 0, height: 0);
  }
  return IconButton(
      onPressed: () async {
        var a = await updateBegenGorulduGunlukAkis(
            //geçici, görüldü düzenlemesi
            token: cp.kullanici.token,
            body: {"gordu": cp.kullanici.data.adSoyad},
            id: akis.id);
        debugPrint(a.toString());
        Pencere().ac(
            content: gorenlerList(list: akis.gordu),
            context: Get.context!,
            baslik: "Görenler");
      },
      icon: const Icon(Icons.visibility));
}

Widget gorenlerList({required List<String> list}) {
  List<Widget> wList = [];
  for (int i = 0; i < list.length; i++) {
    wList.add(goren(isim: list[i], renk: Renk.numaraliRenk(i)));
    wList.add(Divider(height: 2));
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: wList,
  );
}

// Widget goren({required String isim, required Color renk}) {
//   return Row(
//     mainAxisSize: MainAxisSize.max,

//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       SvgPicture.asset(
//         "asset/image/kalp.svg",
//         color: renk,
//       ),
//       Expanded(child: Text(isim, style: TextStyle(color: renk))),
//     ],
//   );
// }
Widget goren({required String isim, required Color renk}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(right: 10.0, bottom: 5.0), // 5px sağ boşluk
        child: SvgPicture.asset(
          "asset/image/kalp.svg",
          color: renk,
        ),
      ),
      SizedBox(width: 10),
      Expanded(child: Text(isim, style: TextStyle(color: renk))),
    ],
  );
}
