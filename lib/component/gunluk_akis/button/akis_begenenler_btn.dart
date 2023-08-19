import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../const/renk.dart';
import '../../../model/web_api/gunluk_akis.dart';
import '../../pencere/uyari_pencere.dart';

Widget akisBegenenlerBtn(GunlukAkisData akis) {
  //akis.begendi = ["dsad", "dasdasd"]; //geçici

  return IconButton(
      onPressed: () async {
        Pencere().ac(
            content: begenenList(list: akis.begendi),
            context: Get.context!,
            baslik: "Beğenenler");
      },
      icon: const Icon(Icons.heart_broken_sharp));
}

Widget begenenList({required List<String> list}) {
  List<Widget> wList = [];
  for (int i = 0; i < list.length; i++) {
    wList.add(begenen(isim: list[i], renk: Renk.numaraliRenk(i)));
    wList.add(Divider(height: 2));
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: wList,
  );
}

// Widget begenen({required String isim, required Color renk}) {
//   return Row(
//     mainAxisSize: MainAxisSize.max,
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       SvgPicture.asset("asset/image/kalp.svg", color: renk),
//       SizedBox(width:10,height:0),
//       Expanded(child: Text(isim, style: TextStyle(color: renk))),
//     ],
//   );
// }

Widget begenen({required String isim, required Color renk}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(right: 5.0, bottom: 5.0), // 5px sağ boşluk
        child: SvgPicture.asset(
          "asset/image/kalp.svg",
          color: renk,
        ),
      ),
      SizedBox(width: 10), // 10 birim genişlik boşluğu
      Expanded(child: Text(isim, style: TextStyle(color: renk))),
    ],
  );
}
