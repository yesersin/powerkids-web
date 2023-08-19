import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/pencere/evet_hayir.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../../service/kullanici/kullanici_sil.dart';
import '../../../../../static/cogretmen.dart';

Widget veliSilBtn({required AnythingVeliData veliData}) {
  return IconButton(
    onPressed: () async {
      bool? cevap = await PencereEvetHayir().sor(
          baslik: "Bu kullanıcıyı silmek istiyor musunuz?"
              "\nKullanıcıya bağlı öğrencilerde silinecektir.");
      if (cevap == false) return;
      debugPrint("sil id:" + veliData.id);
      Get.context!.loaderOverlay.show();

      cevap = await kullaniciSil(token: cp.kullanici.token, id: veliData.id);
      if (cevap == null) {
        toast(msg: hataMesaj);
        Get.context!.loaderOverlay.hide();
        return;
      }
      toast(msg: "Kullanıcı silindi.");
      co.yoneticiVeliGuncelle.value = true;
      co.yoneticiOgrenciGuncelle.value = true;
      Get.context!.loaderOverlay.hide();
    },
    icon: Icon(Icons.delete_forever),
  );
}
