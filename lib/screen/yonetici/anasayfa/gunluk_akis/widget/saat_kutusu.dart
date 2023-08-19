import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/radius.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';

Widget saatKutusu({required COgretmen c}) {
  return InkWell(
    onTap: () async {
      c.akisTarih.value = DateTime.now();
      TimeOfDay? a = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay(hour: 12, minute: 00),
      );
      DateTime d = DateTime.now();
      if (a != null) c.akisTarih.value = DateTime(d.year, d.month, d.day, a.hour, a.minute);
      debugPrint("secilen saat:" + c.akisTarih.toString());
    },
    child: Container(
      width: Get.width * 0.4,
      decoration: BoxDecoration(
          color: Renk.yesil,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(RadiusSabit.akisTextRadius),
              topRight: Radius.circular(RadiusSabit.akisTextRadius))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Obx(
          () => Text(
            Tarih().saatDk(c.akisTarih.value),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}
