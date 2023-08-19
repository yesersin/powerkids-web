import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget saatKutusu({required COgretmen c}) {
  return IconButton(
      onPressed: () async {
        c.akisTarih.value = DateTime.now();
        TimeOfDay? a = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay(hour: 12, minute: 00),
        );
        DateTime d = DateTime.now();
        if (a != null) c.akisTarih.value = DateTime(d.year, d.month, d.day, a.hour, a.minute);
        debugPrint("secilen saat:" + c.akisTarih.toString());
      },
      icon: Icon(Icons.watch_later_outlined));
}
