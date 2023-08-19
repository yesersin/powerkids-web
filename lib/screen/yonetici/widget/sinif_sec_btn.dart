import 'package:com.powerkidsx/screen/yonetici/yonetici_giris.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/radius.dart';
import '../../../const/renk.dart';

// List<String> siniflar = <String>["Minikler", "Bücürler", "Çiçekler"];

Widget sinifSecBtn() => InkWell(
    onTap: () async {
      GroupButtonController controller = GroupButtonController();
      // controller.selectIndex(0);
      Widget b = GroupButton(
        buttons: cp.siniflar.data.map((e) => e.sinifAdi).toList(),
        isRadio: true,
        onSelected: (secilen, index, durum) {
          cp.sinif = cp.siniflar.data[index];
          Get.offAll(() => YoneticiGiris());
          return;
        },
        controller: controller,
        options: GroupButtonOptions(
          borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
          direction: Axis.vertical,
          buttonWidth: Get.width * 0.5,
          buttonHeight: 40,
          elevation: 1,
          spacing: 20,
          selectedColor: Renk.turuncu,
          unselectedColor: Renk.maviAcik,
          selectedTextStyle: TextStyle(color: Colors.white, fontSize: 14),
          unselectedTextStyle: TextStyle(color: Colors.white, fontSize: 14),
        ),
      );
      var a = await Pencere().ac(baslik: "Sınıf Seçiniz", content: b, context: Get.context!);
    },
    child: Text(cp.sinif.sinifAdi));
