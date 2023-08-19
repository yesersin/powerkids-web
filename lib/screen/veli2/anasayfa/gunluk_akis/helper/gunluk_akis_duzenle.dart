import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/pencere/evet_hayir.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/gunluk_akis_ekle_sonuc.dart';
import '../../../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

TextEditingController b = TextEditingController();
TextEditingController a = TextEditingController();

Future<void> gunlukAkisDuzenle({required COgretmen c, required int index}) async {
  b = TextEditingController(text: c.akis[index].baslik);
  a = TextEditingController(text: c.akis[index].aciklama);
  Widget baslik = Textfield().text(
    controller: b,
    textRenk: Colors.black,
    hint: "Başlık",
    onSubmit: (text) {},
  );
  Widget aciklama = Textfield().text(
    controller: a,
    textRenk: Colors.black,
    hint: "Açıklama",
    maxLines: 8,
    onSubmit: (text) {},
  );
  Widget guncelle = Buton().mavi(
      click: () async {
        bool cevap = await PencereEvetHayir().sor(baslik: "Değişiklik kaydedilsin mi?");
        if (cevap == false) return;
        Get.context!.loaderOverlay.show();
        ModelGunlukAkisEkleSonuc? sonuc = await updateGunlukAkis(
            token: cp.kullanici.token,
            body: {"baslik": b.text, "aciklama": a.text},
            id: c.akis[index].id);

        if (sonuc == null) {
          toast(msg: hataMesaj);
        } else {
          c.akis[index] = sonuc.data.akisaCevir();
          toast(msg: "Değişiklik kaydedildi.");
        }
        Get.context!.loaderOverlay.hide();
        Get.back();
      },
      text: "Güncelle");

  Widget duzenle = SingleChildScrollView(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      baslik,
      SizedBox(width: 0, height: 10),
      aciklama,
      SizedBox(width: 0, height: 10),
      guncelle
    ]),
  );
  await Pencere().ac(content: duzenle, context: Get.context!, baslik: "Düzenle");
}
