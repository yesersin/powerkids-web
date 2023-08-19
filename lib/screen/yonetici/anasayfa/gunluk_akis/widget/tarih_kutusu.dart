import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/radius.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';

Widget tarihKutusu({required COgretmen c}) {
  return InkWell(
    onTap: () async {
      DateTime? date = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 7)));
      if (date != null) c.akisTarih.value = date;
    },
    child: Container(
      width: Get.width * 0.4,
      decoration: BoxDecoration(
          color: Renk.yesil,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(RadiusSabit.akisTextRadius),
              topLeft: Radius.circular(RadiusSabit.akisTextRadius))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Obx(
          () => Text(
            Tarih().gunAyYil(c.akisTarih.value),
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
