import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/widget/orta_cizgi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kare_yuvarlak_buton.dart';

Widget serit(
    {required COgretmen c,
    required String solText,
    required String solImage,
    required Color solColor,
    required Widget solSayfa,
    Function? solKomut,
    required String sagText,
    required String sagImage,
    required Color sagColor,
    required Widget sagSayfa,
    Function? sagKomut,
    required Color cizgi}) {
  return Container(
    width: Get.width,
    height: Get.width * 3 / 10 + 50,
    child: Stack(
      children: [
        Container(
          // color: Colors.yellow,
          width: Get.width,
        ),
        ortaCizgi(color: cizgi),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
          child: Align(
              alignment: Alignment.centerLeft,
              child: kareYuvarlak(
                  komut: solKomut,
                  text: solText,
                  image: solImage,
                  renk: solColor,
                  acilacakSayfa: solSayfa,
                  c: c)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
          child: Align(
              alignment: Alignment.centerRight,
              child: kareYuvarlak(
                  komut: sagKomut,
                  text: sagText,
                  image: sagImage,
                  renk: sagColor,
                  acilacakSayfa: sagSayfa,
                  c: c)),
        ),
      ],
    ),
  );
}
