import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget beyazCard({required String baslik, bool baslikOlsun = true, required Widget icerik}) {
  return Container(
    margin: EdgeInsets.only(left: 16, right: 16),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0x111d1617),
          blurRadius: 40,
          offset: Offset(0, 10),
        ),
      ],
      color: Colors.white,
    ),
    child: Column(
      children: [
        Container(width: Get.width),
        (baslikOlsun)
            ? Row(
                children: [
                  Text(
                    baslik,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : SizedBox(),
        Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(5),
          child: icerik,
        )
      ],
    ),
  );
}
