import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/screen/ogretmen/anket/anket_alert.dart';
import 'package:com.powerkidsx/screen/ogretmen/anket/model/model_anket_text_controller.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void anketKontrol() async {
  debugPrint("anket kontrol");
  if (cp.anket == null) return;
  cp.anketController =
      List.generate(cp.anket!.data.length, (index) => ModelAnketTextController());
  for (int i = 0; i < cp.anket!.data.length; i++) {
    // Shared().save(key: cp.anket!.data[i].id, value: cp.anket!.data[i].id); //anketleri kapat
    // Shared().save(key: cp.anket!.data[0].id, value: ""); //anket aç
    if (cp.anket!.data[i].durum) {
      String kayit = await Shared().get(key: cp.anket!.data[i].id);
      if (kayit != "") continue; //daha önce yapılmış, geç
      showDialog(
          barrierColor: Colors.white10,
          context: Get.context!,
          builder: (BuildContext context) {
            return anketAlert(
                anket: cp.anket!.data[i], anketController: cp.anketController[i]);
          });
    }
  }
}
