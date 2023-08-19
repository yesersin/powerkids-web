import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../bildirim/giris.dart';

Widget bildirimSayfasiBtn({required COgretmen c}) {
  return Stack(
    children: [
      IconButton(
          onPressed: () async {
            cp.bildirimSayisi.value = 0;
            Get.context!.loaderOverlay.show();
            await Future.delayed(Duration(seconds: 1));
            Get.context!.loaderOverlay.hide();
            c.tempSayfalar.clear();
            for (int i = 0; i < c.ogretmenSayfalar.length; i++) {
              c.tempSayfalar.add(c.ogretmenSayfalar[i]);
            }
            c.ogretmenSayfalar.value =
                List.generate(c.ogretmenSayfalar.length, (index) => BildirimGiris(c: c));
            c.bildirimSayfasi.value = true;
          },
          icon: SvgPicture.asset("asset/image/bildirim_icon.svg")),
      Obx(() => (cp.bildirimSayisi.value != 0)
          ? Positioned(
              right: 3,
              bottom: 3,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  cp.bildirimSayisi.value.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ))
          : SizedBox()),
    ],
  );
}
