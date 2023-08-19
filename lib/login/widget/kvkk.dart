import 'package:com.powerkidsx/controller/login/c_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/renk.dart';

Widget kvkkWidget({required CLogin c}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [kvkkCheckbox(c: c), kvkkMetinWidget()],
  );
}

Widget kvkkMetinWidget() {
  return Flexible(
    child: TextButton(
      onPressed: () {
        launchUrl(Uri.parse("https://powerkidsapp.com/m/kvkk"));
        //Metotlar().urlAc("https://servisbildirim.com/kvkk");
      },
      child: Text(
        "kvkkonayliyorum".tr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Renk.griMetin),
      ),
    ),
  );
}

Widget kvkkCheckbox({required CLogin c}) {
  return Obx(
    () => Checkbox(
        checkColor: Renk.griMetin,
        activeColor: Colors.white,
        value: c.kvkk.value,
        onChanged: (value) {
          c.kvkk.value = !c.kvkk.value;
          // kvkk = value!;
          // setState(() {});
        }),
  );
}
