import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dil_secimi_btn.dart';

Widget ustLogo({required String image}) {
  return Stack(
    children: [
      SizedBox(width: Get.width, height: 0),
      Image.asset(
        image,
        width: Get.width,
      ),
      Positioned(right: 30, top: 20, child: dilSecimBtn())
      // Positioned(right: 20, top: 20, child: Icon(Icons.language))
      // Image.asset("")
    ],
  );
}
