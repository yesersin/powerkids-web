import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/ogretmen_ders_not.dart';
import '../../../../../model/web_api/ogretmen_ders_not_update_cevap.dart';
import '../../../../../service/ogretmen_ders_not/ogretmen_ders_not_update.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget notGuncelleBtn({required ModelOgretmenDersNot not, required COgretmen c}) {
  return Buton().mavi(
      click: () async {
        if (c.notText.text.length <= 3) {
          toast(msg: "Lütfen en az 5 karakter not yazınız.");
          return;
        }
        Get.context!.loaderOverlay.show();
        ModelOgretmenDersNotUpdateCevap? anketUpdate = await ogretmenDersNotUpdate(
          durum: c.secilenNotDurum.value,
          id: not.data.first.id,
          notText: c.notText.text,
          token: cp.kullanici.token,
        );

        if (anketUpdate == null) {
          toast(msg: hataMesaj);
        } else {
          toast(msg: "İşlem tamamlandı.");
          Get.back();
        }
        Get.context!.loaderOverlay.hide();
      },
      text: "Güncelle");
}
