import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../component/custom/button.dart';
import '../../../component/pencere/uyari_pencere.dart';
import '../../../service/kullanici/kullanici_set_sms_sifre.dart';
import 'yeni_sifre_gonderildi_uyari.dart';

Widget sifremiGonderBtn({required TextEditingController telefon}) {
  return Buton().mavi(
      text: "gonder".tr,
      click: () async {
        if (telefon.text == "") return;
        Get.context!.loaderOverlay.show();
        bool result = await setKullaniciSmsSifre(telefon: telefon.text);
        Get.context!.loaderOverlay.hide();
        if (result) {
          Pencere().ac(
              baslik: "yenisifre".tr, content: yeniSifreGonderildi(), context: Get.context!);
        } else {
          toast(msg: hataMesaj);
        }
      });
}
