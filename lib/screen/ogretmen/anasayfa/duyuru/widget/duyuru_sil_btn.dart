import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/pencere/evet_hayir.dart';
import '../../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/duyuru/duyuru_gelen.dart';
import '../../../../../service/duyuru/duyuru_update.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget duyuruSilBtn({required int index, required ModelDuyuru duyuru, required COgretmen c}) {
  bool result = false;
  if (cp.kullanici.data.yetki.admin) {
    result = true;
  } else if (duyuru.ekleyenId == cp.kullanici.data.id) {
    result = true;
  }
  if (result) {
    return IconButton(
        onPressed: () async {
          bool cevap =
              await PencereEvetHayir().sor(baslik: "Bu duyuruyu silmek istiyor musunuz?");
          if (cevap == false) return;
          Get.context!.loaderOverlay.show();
          ModelDuyuru? sonuc = await updateDuyuru(
              token: cp.kullanici.token, body: {"durum": "false"}, id: c.duyuruList[index].id);

          if (sonuc == null) {
            toast(msg: hataMesaj);
          } else {
            c.duyuruList[index] = sonuc;
            toast(msg: "Duyuru silindi.");
          }
          Get.context!.loaderOverlay.hide();
        },
        icon: Icon(Icons.delete_forever));
  } else {
    return SizedBox(width: 0, height: 0);
  }
}
