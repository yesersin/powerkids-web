import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../const/radius.dart';

Widget yetkiBtn({
  required Color renk,
  required String text,
  required String image,
  required Widget sayfa,
  Function? komut,
}) {
  return Center(
    child: Container(
      width: Get.width * 0.7,
      height: 70,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () async {
          if (komut != null) await komut();

          Get.to(
            () => sayfa,
          );
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(8),
                width: Get.width * 0.4,
                height: 48,
                decoration: BoxDecoration(
                  color: renk,
                  borderRadius: BorderRadius.circular(RadiusSabit.yetkiButtonRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: SvgPicture.asset(image),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                width: Get.width * 0.5,
                height: 60,
                decoration: BoxDecoration(
                  color: renk,
                  borderRadius: BorderRadius.circular(RadiusSabit.yetkiButtonRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  text,
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
