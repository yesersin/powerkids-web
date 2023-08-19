import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget kareYuvarlak(
    {required String text,
    required String image,
    required Color renk,
    required Widget acilacakSayfa,
    required COgretmen c,
    Function? komut}) {
  //komut sayfa açılırken kod taşımak için kullanılır
  return InkWell(
    onTap: () {
      if (komut != null) komut();
      c.ogretmenSayfalar[0] = acilacakSayfa;
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width * 3 / 10,
          height: Get.width * 3 / 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Color(0x3f000000),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
            color: renk,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SvgPicture.asset(
              image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            // textScaleFactor: 1.3,
          ),
        ),
      ],
    ),
  );
}
