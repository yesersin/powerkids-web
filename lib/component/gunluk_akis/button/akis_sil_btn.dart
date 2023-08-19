import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../const/yetki_text.dart';
import '../../../controller/ogretmen/c_ogretmen.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/gunluk_akis.dart';
import '../../../model/web_api/gunluk_akis_ekle_sonuc.dart';
import '../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../static/cprogram.dart';
import '../../../static/hata_mesaj.dart';
import '../../../static/yetki.dart';
import '../../pencere/evet_hayir.dart';

Widget akisSilBtn({required int index, required GunlukAkisData akis, required COgretmen c}) {
  if (yetkiText == YetkiText.veli) {
    //yetki veli ise gösterme
    return SizedBox(width: 0, height: 0);
  }
  bool result = false;
  if (cp.kullanici.data.yetki.admin) {
    result = true;
  } else if (akis.ekleyenId == cp.kullanici.data.id) {
    result = true;
  }
  if (result) {
    return IconButton(
        onPressed: () async {
          bool cevap =
              await PencereEvetHayir().sor(baslik: "Bu etkinliği silmek istiyor musunuz?");
          if (cevap == false) return;
          Get.context!.loaderOverlay.show();
          ModelGunlukAkisEkleSonuc? sonuc = await updateGunlukAkis(
              token: cp.kullanici.token, body: {"durum": "false"}, id: c.akis[index].id);

          if (sonuc == null) {
            toast(msg: hataMesaj);
          } else {
            c.akis[index] = sonuc.data.akisaCevir();
            toast(msg: "Günlük akış silindi.");
          }
          Get.context!.loaderOverlay.hide();
        },
        icon: Icon(Icons.delete_forever));
  } else {
    return SizedBox(width: 0, height: 0);
  }
}
