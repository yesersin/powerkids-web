import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget ortaCizgi({required Color color}) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      width: Get.width * 0.5,
      height: Get.width * 0.05,
      // color: Colors.blue,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        color: color,
      ),
    ),
  );
}
