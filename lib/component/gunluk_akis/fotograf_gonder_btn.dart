import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/ogretmen/anasayfa/gunluk_akis/helper/gunluk_akis_gonder.dart';
import '../custom/button.dart';

Widget gunlukAkisFotografGonderBtn(
    {required COgretmen c,
    required TextEditingController baslik,
    required TextEditingController aciklama,
    required bool fotograf}) {
  // Get.context!.loaderOverlay.hide(); //geçici
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
          width: Get.width * 0.3,
          child: Buton().mavi(
              click: () async {
                await gunlukAkisGonder(
                    c: c, baslik: baslik, aciklama: aciklama, fotograf: fotograf);
              },
              text: "Gönder"))
    ],
  );
}
