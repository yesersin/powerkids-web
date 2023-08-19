import 'package:com.powerkidsx/const/upload_file_tip.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis_ekle_sonuc.dart';
import 'package:com.powerkidsx/screen/ogretmen/widget/yukleniyor_sayili.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../const/akis_add_tip.dart';
import '../../../../../helper/bildirim_gonder.dart';
import '../../../../../model/web_api/kullanici/kullanici_notification.dart';
import '../../../../../model/web_api/upload_file.dart';
import '../../../../../service/gunluk_akis/gunluk_akis_ekle.dart';
import '../../../../../service/gunluk_akis/gunuk_akis_upload_foto.dart';
import '../../../../../service/kullanici/kullanici_get_notification_list.dart';

Future<void> gunlukAkisGonder(
    {required COgretmen c,
    required TextEditingController baslik,
    required bool fotograf,
    required TextEditingController aciklama}) async {
  if (c.akisSecilenDosyalar.isEmpty) {
    if (fotograf) {
      toast(msg: "Lütfen fotoğraf ekleyiniz.");
    } else {
      toast(msg: "Lütfen video ekleyiniz.");
    }

    return;
  }
  if (baslik.text.length < 3 && baslik.text.length > 64) {
    toast(msg: "Lütfen en az 3-64 karakter yazınız.");
    return;
  }
  int toplam = c.akisSecilenDosyalar.length;
  int basarili = 0;
  c.yuklenenDosyaSayisi.value = 0;
  c.yuklenenDosyaUrl.clear();
  Get.context!.loaderOverlay
      .show(widget: Obx(() => yukleniyorSayili(c.yuklenenDosyaSayisi.value, toplam)));

  //dosya yükle
  for (int i = 0; i < c.akisSecilenDosyalar.length; i++) {
    ModelUploadFile? upload = await gunlukAkisUploadFoto(
        sinifId: cp.sinif.id,
        token: cp.kullanici.token,
        ekleyenId: cp.kullanici.data.id,
        okulId: cp.okul!.data.id,
        tip: fotograf ? UploadFileTip.fotograf : UploadFileTip.video,
        file: c.akisSecilenDosyalar[i]);
    if (upload == null) {
      toast(msg: hataMesaj);
      Get.context!.loaderOverlay.hide();
      return;
    } else {
      // toast(msg: (i + 1).toString() + ".fotoğraf yüklendi.", gravity: ToastGravity.BOTTOM);
      basarili++;
      c.yuklenenDosyaSayisi.value++;
      c.yuklenenDosyaUrl.add(upload.data);
      debugPrint(upload.data.toString());
    }
  }
  //dosya yükle

  //akış ekle

  ModelGunlukAkisEkleSonuc? sonuc = await gunlukAkisEkle(
    okulId: cp.okul!.data.id,
    sinifId: cp.sinif.id,
    donem: cp.okulAyarlar.data.donem,
    token: cp.kullanici.token,
    aciklama: (aciklama.text == "") ? "boş" : aciklama.text,
    ekleyenId: cp.kullanici.data.id,
    url: c.yuklenenDosyaUrl,
    baslik: baslik.text,
    tarihSaat: c.akisTarih.value,
    onaylamaIzni: cp.okulAyarlar.data.onaylamaIzni.toString(),
    tip: fotograf ? AkisAddTip.fotograf : AkisAddTip.video,
  );
  if (sonuc == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    c.akis.add(sonuc.data.akisaCevir());
    c.akisSecilenDosyalar.clear();
    baslik.text = "";
    aciklama.text = "";
    toast(msg: "Günlük akış eklendi.");
    //bildirim gönder
    if (cp.okulAyarlar.data.onaylamaIzni == false) {
      debugPrint("liste getir");
      ModelKullaniciNotification? list = await getKullaniciNotificationList(
          sinifId: cp.sinif.id, okulId: cp.okul!.data.id, token: cp.kullanici.token);
      debugPrint("liste:" + list.toString());
      if (list != null) {
        debugPrint("gönderiliyor");
        bildirimGonder(list: list.data, tip: "2", pushBildirim: true);
      }
    }
  }
  //akış ekle
  Get.context!.loaderOverlay.hide();
  toast(msg: "$basarili/$toplam " + (fotograf ? "fotoğraf" : "video") + "yüklendi.");
}
