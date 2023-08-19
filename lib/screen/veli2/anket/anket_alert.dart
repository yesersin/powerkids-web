import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/anket/anket.dart';
import 'package:com.powerkidsx/screen/ogretmen/anket/model/model_anket_text_controller.dart';
import 'package:com.powerkidsx/service/anket/anket_cevap_ver.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../model/web_api/anket/anket_cevap.dart';

Widget anketAlert(
    {required AnketData anket, required ModelAnketTextController anketController}) {
  List<int> puan = [1, 2, 3, 4];
  List<IconData> widget = [
    Icons.face_retouching_off_rounded,
    Icons.face_rounded,
    Icons.face_retouching_natural,
    Icons.tag_faces_sharp,
  ];

  return AlertDialog(
    contentPadding: EdgeInsets.symmetric(horizontal: 5),
    insetPadding: EdgeInsets.symmetric(horizontal: 5),
    title: Center(child: Text("Görüşleriniz bizim için değerlidir", style: TextStyle())),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (anket.puan)
            GroupButton<int>(
              controller: anketController.butonController,
              buttons: puan,
              buttonIndexedBuilder: (select, index, context) {
                if (select) {
                  debugPrint(anketController.butonController.selectedIndex.toString());
                  return Icon(
                    widget[index],
                    color: Colors.blue,
                    size: 32,
                  );
                } else {
                  return Icon(
                    widget[index],
                    size: 32,
                  );
                }
              },
            ),
          SizedBox(
            width: Get.width,
            height: 15,
          ),
          if (anket.bir != "")
            Column(
              children: [
                Textfield().text(
                  controller: anketController.c1,
                  textRenk: Colors.black,
                  hint: anket.bir,
                  onSubmit: (text) {},
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          if (anket.iki != "")
            Column(
              children: [
                Textfield().text(
                  controller: anketController.c2,
                  textRenk: Colors.black,
                  hint: anket.iki,
                  onSubmit: (text) {},
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          if (anket.uc != "")
            Column(
              children: [
                Textfield().text(
                  controller: anketController.c3,
                  textRenk: Colors.black,
                  hint: anket.uc,
                  onSubmit: (text) {},
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
          if (anket.dort != "")
            Column(
              children: [
                Textfield().text(
                  controller: anketController.c4,
                  textRenk: Colors.black,
                  hint: anket.dort,
                  onSubmit: (text) {},
                ),
                SizedBox(width: 0, height: 10),
              ],
            ),
        ],
      ),
    ),
    actions: [
      Center(
        child: Buton().mavi(
          click: () async {
            if (anket.puan && anketController.butonController.selectedIndex == null) {
              toast(msg: "Lütfen bir yüz ifadesi seçiniz.");
              return;
            }

            if (anket.bir != "" && anketController.c1.text == "") {
              toast(msg: "Lütfen birinci soruya cevap verin.");
              return;
            }
            if (anket.iki != "" && anketController.c2.text == "") {
              toast(msg: "Lütfen ikinci soruya cevap verin.");
              return;
            }
            if (anket.uc != "" && anketController.c3.text == "") {
              toast(msg: "Lütfen üçüncü soruya cevap verin.");
              return;
            }
            if (anket.dort != "" && anketController.c4.text == "") {
              toast(msg: "Lütfen dördüncü soruya cevap verin.");
              return;
            }

            Get.context!.loaderOverlay.show();

            ModelAnketCevap? anketUpdate = await anketCevapVer(
                anketController: anketController,
                token: cp.kullanici.token,
                gelenAnket: anket);
            debugPrint("anket id:" + anket.id);
            if (anketUpdate == null) {
              toast(msg: hataMesaj);
            } else {
              toast(msg: "Anket gönderildi.");
              await Shared().save(key: anket.id, value: anket.id); //anketi kaydet
            }
            Get.context!.loaderOverlay.hide();
            Get.back();
          },
          renk: Renk.yesil,
          text: "Gönder",
        ),
      )
    ],
  );
}
