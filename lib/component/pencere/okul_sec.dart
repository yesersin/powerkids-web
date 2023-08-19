import 'package:com.powerkidsx/model/web_api/okul/okul.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<ModelOkul?> okulSec(
    {String? baslik, required BuildContext context, required List<ModelOkul> okulList}) async {
  List<Widget> list = [];
  list.add(SizedBox(width: context.width, height: 0));
  ModelOkul? okul = null;
  for (int i = 0; i < okulList.length; i++) {
    list.add(
      MaterialButton(
          onPressed: () {
            okul = okulList[i];
            Get.back();
          },
          child: Text(okulList[i].data.okulAdi)),
    );
  }
  debugPrint("x1");
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
          title: Row(
            children: [
              Expanded(child: Center(child: Text(baslik ?? ""))),
            ],
          ),
          content: Container(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: list,
              ),
            ),
          ),
        );
      });
  debugPrint("x2");
  return okul;
}
