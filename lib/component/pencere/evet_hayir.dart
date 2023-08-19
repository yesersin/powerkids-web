import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom/button.dart';

class PencereEvetHayir {
  Future<bool> sor({required String baslik}) async {
    bool cevap = false;

    await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: Get.width - 10),
                Buton().mavi(
                    click: () {
                      cevap = true;
                      Get.back();
                    },
                    text: "evet".tr),
                SizedBox(height: 10),
                Buton().mavi(
                    click: () {
                      Get.back();
                    },
                    text: "hayir".tr),
              ],
            ),
            scrollable: true,
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            title: Row(
              children: [
                Expanded(child: Center(child: Text(baslik))),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
          );
        });
    return cevap;
  }
}
