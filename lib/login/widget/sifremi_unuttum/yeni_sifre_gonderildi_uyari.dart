import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/custom/button.dart';
import '../../../const/renk.dart';

Widget yeniSifreGonderildi() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "yssmsuyari".tr,
        style: TextStyle(color: Renk.griMetin),
      ),
      SizedBox(height: 25),
      Buton().mavi(
        click: () {
          Get.back();
          Get.back();
        },
        text: "tamam".tr,
      )
    ],
  );
}
