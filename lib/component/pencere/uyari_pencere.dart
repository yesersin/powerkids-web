import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pencere {
  Future<dynamic> ac(
      {String? baslik,
      required Widget content,
      required BuildContext context,
      double yukseklik = 0}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.symmetric(horizontal: 10),
            scrollable: true,
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            title: Row(
              children: [
                Expanded(child: Center(child: Text(baslik ?? ""))),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            content: Container(
              height: yukseklik == 0 ? 250 : yukseklik,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: Get.width - 10),
                    content,
                  ],
                ),
              ),
            ),
          );
        });
    return "";
  }
}
