import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../component/custom/text_field.dart';
import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../helper/ogrenci_sayisi.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_ekle_cevap.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_sayisi.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../service/kullanici/kullanici_push_ogrenci.dart';
import '../../../../../service/ogrenci/ogrenci_ekle.dart';
import '../../../../../service/ogrenci/ogrenci_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget veliEkOgrenciEkleBtn({required AnythingVeliData veliData}) {
  return ElevatedButton(
    onPressed: () async {
      ModelOgrenciSayisi? sayi = await ogrenciSayisiYukle();
      if (sayi == null) {
        toast(msg: "Öğrenci kontejan bilgisi gelmedi!");
        return;
      } else if ((sayi.data.fark < 1)) {
        toast(msg: "Kontenjan doldu. Lütfen iletişime geçin!");
        return;
      }
      _ogrenciAdi = TextEditingController();
      _veliTel = TextEditingController();

      _sinifList.clear();
      for (int i = 0; i < cp.siniflar.data.length; i++) {
        _sinifList.add(cp.siniflar.data[i].sinifAdi);
      }
      _sinifGrp.selectIndex(0);

      Pencere().ac(
          content: _veliEklePencere(veliData: veliData),
          context: Get.context!,
          yukseklik: Get.height * 0.5);
    },
    child: Text("+Öğrenci"),
  );
}

TextEditingController _ogrenciAdi = TextEditingController();
TextEditingController _veliTel = TextEditingController();
GroupButtonController _sinifGrp = GroupButtonController();
var _sinifList = [];

Widget _veliEklePencere({required AnythingVeliData veliData}) {
  return SingleChildScrollView(
    child: Column(children: [
      Text("Öğrenci Bilgileri", style: TextStyle()),
      Textfield().text(
          controller: _ogrenciAdi,
          onSubmit: (value) {},
          hint: "Öğrenci Adı Soyadı",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 20),
      GroupButton(
        controller: _sinifGrp,
        buttons: _sinifList,
        isRadio: true,
        maxSelected: _sinifList.length,
      ),
      SizedBox(width: 0, height: 20),
      Buton().mavi(
          click: () {
            _ekle(veliData: veliData);
          },
          text: "Ekle"),
      SizedBox(width: 0, height: 50),
    ]),
  );
}

Future<void> _ekle({required AnythingVeliData veliData}) async {
  //_ogrenciAdi.text = "öğrenci deneme" + Random().nextInt(999).toString();

  if (_ogrenciAdi.text == "") {
    toast(msg: "Öğrenci adı girmelisiniz!");
    return;
  }

  Get.context!.loaderOverlay.show();
  String sinifId = cp.siniflar.data[_sinifGrp.selectedIndex ?? 0].id;
  //öğrenci ekleniyor
  Map<String, String> body = {};
  body.addAll({"sinifId": sinifId});
  body.addAll({"okulId": cp.okul!.data.id});
  body.addAll({"adSoyad": _ogrenciAdi.text});
  ModelOgrenciEkleCevap? ogrenci = await ogrenciEkle(
    token: cp.kullanici.token,
    body: body,
  );
  if (ogrenci == null) {
    toast(msg: hataMesaj);
    Get.context!.loaderOverlay.hide();
    return;
  }
  //öğrenci ekleniyor

  //öğrenci-push ekleniyor
  Map<String, String> body2 = {};
  body2.addAll({"_id": veliData.id});
  body2.addAll({"ogrenciId": ogrenci.data.id});
  body2.addAll({"durum": "true"});

  String? islem = await kullaniciPushOgrenci(
    token: cp.kullanici.token,
    body: body2,
  );
  if (islem == null) {
    //veli push yapılamadı öğrenciyi sil
    body = {};
    body.addAll({"_id": ogrenci.data.id});
    body.addAll({"durum": false.toString()});
    ModelOgrenciUpdateCevap? ogrenciSil = await ogrenciUpdate(
      token: cp.kullanici.token,
      body: body,
    );

    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    toast(msg: "Öğrenci eklendi.");
    co.yoneticiVeliGuncelle.value = true;
    Get.back();
  }

  Get.context!.loaderOverlay.hide();
  //ogrenci-push ekleniyor
}
