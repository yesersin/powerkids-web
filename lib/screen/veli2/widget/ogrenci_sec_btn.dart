import 'package:com.powerkidsx/screen/veli2/veli_giris.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../component/pencere/uyari_pencere.dart';
import '../../../const/radius.dart';
import '../../../const/renk.dart';
import '../../../static/cogretmen.dart';
import '../anasayfa/veli_anasayfa_giris.dart';

List<String> siniflar = <String>["Minikler", "Bücürler", "Çiçekler"];

Widget ogrenciSecBtn() => InkWell(
    onTap: () async {
      co.veliAnasayfaSayfalari.clear();
      co.veliAnasayfaSayfalari.add(VeliAnasayfaGiris());
      co.veliSayfalar[0] = VeliAnasayfaGiris();
      co.veliTabController.jumpToTab(0);

      GroupButtonController controller = GroupButtonController();
      // controller.selectIndex(0);
      Widget b = GroupButton(
        buttons: co.veliOgrenciList.map((e) => e.data.adSoyad).toList(),
        isRadio: true,
        onSelected: (secilen, index, durum) {
          co.veliSecilenOgrenci.value = co.veliOgrenciList[index];
          co.profilSecilenOgrenci.value =
              co.veliOgrenciList[index].data.modelOgrenciDonustur();
          Get.offAll(
            () => VeliGiris(),
          );
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
      var a = await Pencere().ac(baslik: "Öğrenci Seçiniz", content: b, context: Get.context!);
    },
    child: Text(co.veliSecilenOgrenci.value.data.adSoyad));
