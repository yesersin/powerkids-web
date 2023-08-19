import 'package:com.powerkidsx/login/widget/sifremi_unuttum/sifremi_unuttum_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/renk.dart';
import '../../../const/versiyon.dart';

Widget sifremiUnuttumBtn({required TextEditingController telefon}) {
  return TextButton(
    onPressed: () {
      Pencere().ac(
          baslik: "sifreunuttum".tr,
          content: sifremiUnuttumWidget(telefon: telefon),
          context: Get.context!);
      // c.sifreUnuttum.value = true;

      // Metotlar().urlAc("https://servisbildirim.com/kvkk");
    },
    child: Text(
      "sifreunuttum".tr,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: Renk.griMetin,
      ),
    ),
  );
}

Widget version() {
  return TextButton(
    onPressed: () {
      launchUrl(Uri.parse("https://powerkidsapp.com"));
    },
    child: Text(
      "v" + androidVersion,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: Renk.griMetin,
      ),
    ),
  );
}
