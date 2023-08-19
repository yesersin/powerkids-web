import 'package:com.powerkidsx/screen/ogretmen/ogretmen_giris.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/radius.dart';
import '../../../const/renk.dart';

//List<String> siniflar = <String>["Minikler", "Bücürler", "Çiçekler"];

Widget sinifSecBtn() {
  return InkWell(
      onTap: () async {
        GroupButtonController controller = GroupButtonController();
        // controller.selectIndex(0);
        Widget b = GroupButton(
          buttons: ogretmenSiniflari(),
          isRadio: true,
          onSelected: (secilen, index, durum) {
            int i = cp.siniflar.data
                .indexWhere((element) => element.sinifAdi == ogretmenSiniflari()[index]);
            cp.sinif = cp.siniflar.data[i];
            Get.offAll(() => OgretmenGiris());
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
}

List<String> ogretmenSiniflari() {
  debugPrint("kullanıcının sınıfları:${cp.kullanici.data.sinifId}");
  List<String> list = [];
  for (int i = 0; i < cp.kullanici.data.sinifId.length; i++) {
    int index =
        cp.siniflar.data.indexWhere((element) => cp.kullanici.data.sinifId[i] == element.id);
    debugPrint("index:" + index.toString());
    if (index != -1) {
      list.add(cp.siniflar.data[index].sinifAdi);
      debugPrint("eklenene sınıf:" + cp.siniflar.data[index].sinifAdi);
    }
  }
  return list;
}
