import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/bildirim_gonder.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../const/yetki_text.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/gunluk_akis.dart';
import '../../../model/web_api/gunluk_akis_ekle_sonuc.dart';
import '../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../service/kullanici/kullanici_get_notification_list.dart';
import '../../../static/cprogram.dart';
import '../../../static/hata_mesaj.dart';
import '../../../static/yetki.dart';
import '../../pencere/evet_hayir.dart';

Widget akisOnayBtn({required int index, required GunlukAkisData akis, required COgretmen c}) {
  if (yetkiText == YetkiText.veli) {
    //yetki veli ise gösterme
    return SizedBox(width: 0, height: 0);
  }
  bool result = false;
  if (akis.onayDurum) {
    //onaylanmış
    result = false;
  } else if (akis.onayDurum == false && akis.onaylamaIzni == false) {
    //akışın onaylanmasına gerek yok
    result = false;
  } else if (cp.kullanici.data.yetki.admin) {
    result = true;
  } else if (cp.okulAyarlar.data.onaylamaKullaniciId
      .any((element) => element == cp.kullanici.data.id)) {
    //onay izni olan kullanıcıyada göster
    result = true;
  }

  if (result) {
    return IconButton(
        onPressed: () async {
          bool cevap = await PencereEvetHayir().sor(baslik: "Bu etkinliği onaylansın mı?");
          if (cevap == false) return;
          Get.context!.loaderOverlay.show();
          ModelGunlukAkisEkleSonuc? sonuc = await updateGunlukAkis(
              token: cp.kullanici.token, body: {"onayDurum": "true"}, id: c.akis[index].id);

          if (sonuc == null) {
            toast(msg: hataMesaj);
          } else {
            c.akis[index] = sonuc.data.akisaCevir();
            ModelKullaniciNotification? list = await getKullaniciNotificationList(
                sinifId: cp.sinif.id, okulId: cp.okul!.data.id, token: cp.kullanici.token);
            if (list != null) {
              bildirimGonder(list: list.data, tip: '2', pushBildirim: true);
            }
            toast(msg: "Onaylandı.");
          }
          Get.context!.loaderOverlay.hide();
        },
        icon: Icon(Icons.check));
  } else {
    return SizedBox(width: 0, height: 0);
  }
}
