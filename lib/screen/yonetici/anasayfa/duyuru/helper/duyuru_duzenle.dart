import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../component/custom/text_field.dart';
import '../../../../../component/pencere/evet_hayir.dart';
import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/duyuru/duyuru_gelen.dart';
import '../../../../../service/duyuru/duyuru_update.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Future<void> duyuruDuzenle(
    {required COgretmen c,
    required int index,
    required TextEditingController a,
    required TextEditingController b}) async {
  b = TextEditingController(text: c.duyuruList[index].baslik);
  a = TextEditingController(text: c.duyuruList[index].aciklama);
  c.duyuruDuzenlePin.value = c.duyuruList[index].pin;
  Widget baslik = Textfield().text(
    controller: b,
    textRenk: Colors.black,
    hint: "Başlık",
    onSubmit: (text) {},
  );
  Widget aciklama = Textfield().text(
      onSubmit: (text) {},
      controller: a,
      textRenk: Colors.black,
      hint: "Açıklama",
      maxLines: 8);
  Widget guncelle = Buton().mavi(
      click: () async {
        bool cevap = await PencereEvetHayir().sor(baslik: "Değişiklik kaydedilsin mi?");
        if (cevap == false) return;
        Get.context!.loaderOverlay.show();
        ModelDuyuru? sonuc = await updateDuyuru(
            token: cp.kullanici.token,
            body: {
              "baslik": b.text,
              "aciklama": a.text,
              "pin": c.duyuruDuzenlePin.value.toString(),
            },
            id: c.duyuruList[index].id);

        if (sonuc == null) {
          toast(msg: hataMesaj);
        } else {
          c.duyuruList[index] = sonuc;
          toast(msg: "Duyuru güncellendi.");
        }

        Get.context!.loaderOverlay.hide();
        Get.back();
      },
      text: "Güncelle");
  Widget pin = Row(
    children: [
      Obx(
        () => Switch(
          value: c.duyuruDuzenlePin.value,
          onChanged: (value) {
            c.duyuruDuzenlePin.value = value;
          },
        ),
      ),
      Text("Pin", style: TextStyle()),
    ],
  );

  Widget duzenle = SingleChildScrollView(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      baslik,
      SizedBox(width: 0, height: 10),
      aciklama,
      SizedBox(width: 0, height: 10),
      pin,
      SizedBox(width: 0, height: 10),
      guncelle,
    ]),
  );
  await Pencere().ac(content: duzenle, context: Get.context!, baslik: "Düzenle");
}
