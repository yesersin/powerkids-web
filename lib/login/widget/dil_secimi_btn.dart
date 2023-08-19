import 'package:com.powerkidsx/const/shared_pref_keys.dart';
import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../component/pencere/uyari_pencere.dart';
import '../../const/radius.dart';
import '../../const/renk.dart';

List<String> diller = <String>["Türkçe", "İngilizce", "Arapça"];

Widget dilSecimBtn() {
  GroupButtonController controller = GroupButtonController();
  if (cp.dil == "TUR") {
    controller
        .selectIndex(cp.besadim.data.first.diller.indexWhere((element) => element == "TUR"));
  } else if (cp.dil == "ENG") {
    controller
        .selectIndex(cp.besadim.data.first.diller.indexWhere((element) => element == "ENG"));
  } else if (cp.dil == "RUS") {
    controller
        .selectIndex(cp.besadim.data.first.diller.indexWhere((element) => element == "RUS"));
  } else if (cp.dil == "ARB") {
    controller
        .selectIndex(cp.besadim.data.first.diller.indexWhere((element) => element == "ARB"));
  } else {
    controller
        .selectIndex(cp.besadim.data.first.diller.indexWhere((element) => element == "TUR"));
  }

  return MaterialButton(
    onPressed: () async {
      Widget dilButonlar = GroupButton(
        buttons: cp.besadim.data.first.diller,
        isRadio: true,
        onSelected: (secilen, index, durum) {
          print(secilen);
          print(index);
          print(durum);
          if (secilen.toString() == "TUR") {
            Shared().save(key: SharedKeys().dil, value: "TUR");
            Get.updateLocale(Locale("tr", "TR"));
            // Get.back();
          } else if (secilen.toString() == "ENG") {
            Shared().save(key: SharedKeys().dil, value: "ENG");
            Get.updateLocale(Locale("en", "US"));
            // Get.back();
          } else if (secilen.toString() == "ARB") {
            Shared().save(key: SharedKeys().dil, value: "ARB");
            Get.updateLocale(Locale("ar", "ARB"));
            // Get.back();
          } else if (secilen.toString() == "RUS") {
            Shared().save(key: SharedKeys().dil, value: "RUS");
            Get.updateLocale(Locale("ru", "RU"));
            // Get.back();
          }
        },
        controller: controller,
        options: GroupButtonOptions(
          borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
          direction: Axis.vertical,
          buttonWidth: Get.width * 0.5,
          buttonHeight: 50,
          elevation: 1,
          spacing: 20,
          selectedColor: Renk.turuncu,
          unselectedColor: Renk.maviAcik,
          selectedTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          unselectedTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
      var a = await Pencere().ac(
          baslik: "dilseciniz".tr,
          content: dilButonlar,
          context: Get.context!,
          yukseklik: 300);
    },
    child: Column(
      children: [
        SvgPicture.asset("asset/image/giris_dil_secimi.svg"),
        Text(
          "Diller",
          style: TextStyle(color: Renk.griMetin),
        )
      ],
    ),
  );
}
