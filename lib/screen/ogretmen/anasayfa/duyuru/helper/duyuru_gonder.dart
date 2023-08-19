import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_add_cevap.dart';
import 'package:com.powerkidsx/service/duyuru/duyuru_add.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../helper/bildirim_gonder.dart';
import '../../../../../model/web_api/kullanici/kullanici_notification.dart';
import '../../../../../service/kullanici/kullanici_get_notification_list.dart';

Future<void> duyuruGonder(
    {required COgretmen c,
    required TextEditingController baslik,
    required TextEditingController aciklama,
    String? sinifId}) async {
  if (baslik.text.length < 3 && baslik.text.length > 64) {
    toast(msg: "Lütfen en az 3-64 karakter yazınız.");
    return;
  }

  Get.context!.loaderOverlay.show();

  //duyuru ekle
  //veli ve öğretmen seçiliyse öncelik=3, sadece veli=1, sadece öğretmen=2,
  String oncelik = "";
  if (c.duyuruVeli.value && c.duyuruOgretmen.value) {
    oncelik = "3";
  } else if (c.duyuruOgretmen.value) {
    oncelik = "2";
  } else if (c.duyuruVeli.value) {
    oncelik = "1";
  }

  ModelDuyuruAddCevap? sonuc = await addDuyuru(
    okulId: cp.okul!.data.id,
    sinifId: sinifId ?? cp.sinif.id,
    token: cp.kullanici.token,
    aciklama: (aciklama.text == "") ? "" : aciklama.text,
    ekleyenId: cp.kullanici.data.id,
    baslik: baslik.text,
    file: c.duyuruEkleSecilenDosyalar.isNotEmpty ? c.duyuruEkleSecilenDosyalar.first : null,
    dil: cp.dil,
    ebeveyn: c.duyuruEbeveyn.value.toString(),
    ekleyenAd: cp.kullanici.data.adSoyad,
    onayDurum: cp.okulAyarlar.data.onaylamaIzni.toString(),
    //DİKKAT
    oncelik: oncelik,
  );
  if (sonuc == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    toast(msg: "Duyuru eklendi.");
    //bildirim gönder

    ModelKullaniciNotification? list = await getKullaniciNotificationList(
        sinifId: sinifId ?? cp.sinif.id, okulId: cp.okul!.data.id, token: cp.kullanici.token);
    if (list != null) {
      bildirimGonder(list: list.data, tip: "2", pushBildirim: true);
    }

    c.duyuruList.add(sonuc.data.duyuruyaCevir());
  }
  //duyuru ekle
  Get.context!.loaderOverlay.hide();
}
