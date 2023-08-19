import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../component/custom/text_field.dart';
import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_get_anything.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../service/ogrenci/ogrenci_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget orenciDuzenleBtn({required OgrenciAnythingData ogrenci}) {
  return ElevatedButton(
    onPressed: () {
      _ogrenciAdi = TextEditingController(text: ogrenci.adSoyad);
      _sinif = GroupButtonController();
      int index = cp.siniflar.data.indexWhere((element) => element.id == ogrenci.sinifId);
      if (index == -1) {
        toast(msg: "Öğrencinin sınıfı bulunamadı! Lütfen bir sınıf seçiniz.");
      } else {
        _sinif.selectIndex(index);
      }
      Pencere().ac(
          content: _veliEklePencere(ogrenci: ogrenci),
          context: Get.context!,
          yukseklik: Get.height * 0.5,
          baslik: "Öğrenci Düzenle");
    },
    child: Icon(Icons.edit),
  );
}

TextEditingController _ogrenciAdi = TextEditingController();
GroupButtonController _sinif = GroupButtonController();

Widget _veliEklePencere({required OgrenciAnythingData ogrenci}) {
  return SingleChildScrollView(
    child: Column(children: [
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever)),
      //   ],
      // ),
      Textfield().text(
          controller: _ogrenciAdi,
          onSubmit: (value) {},
          hint: "Öğrenci Adı Soyadı",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 10),
      GroupButton(
        controller: _sinif,
        buttons: cp.siniflar.data.map((e) => e.sinifAdi).toList(),
      ),
      SizedBox(width: 0, height: 10),
      Buton().mavi(
          click: () {
            _guncelle(ogrenci: ogrenci);
          },
          text: "Güncelle"),
      SizedBox(width: 0, height: 50),
    ]),
  );
}

Future<void> _guncelle({required OgrenciAnythingData ogrenci}) async {
  // _ogrenciAdi.text = "öğrenci deneme" + Random().nextInt(999).toString();

  if (_ogrenciAdi.text == "") {
    toast(msg: "Öğrenci adı girmelisiniz!");
    return;
  }
  String secilenSinif = cp.siniflar.data[_sinif.selectedIndex ?? 0].id;
  Get.context!.loaderOverlay.show();
  Map<String, String> body = {};
  body.addAll({"adSoyad": _ogrenciAdi.text});
  body.addAll({"sinifId": secilenSinif});
  body.addAll({"_id": ogrenci.id});
  ModelOgrenciUpdateCevap? update = await ogrenciUpdate(body: body, token: cp.kullanici.token);
  if (update == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  }

  toast(msg: "Öğrenci bilgileri güncellendi.");
  co.yoneticiOgrenciGuncelle.value = true;
  Get.context!.loaderOverlay.hide();
  Get.back();
}
