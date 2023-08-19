import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../component/custom/text_field.dart';
import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../../model/web_api/kullanici/kullanici_ekle_cevap.dart';
import '../../../../../model/web_api/kullanici/kullanici_getir.dart';
import '../../../../../service/kullanici/kullanici_ekle.dart';
import '../../../../../service/kullanici/kullanici_getir.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget veliEkVeliEkleBtn({required AnythingVeliData veliData}) {
  return ElevatedButton(
    onPressed: () {
      _veliAdi = TextEditingController();
      _veliTel = TextEditingController();
      Pencere().ac(
          content: _veliEklePencere(veliData: veliData),
          context: Get.context!,
          yukseklik: Get.height * 0.5);
    },
    child: Text("+Veli"),
  );
}

var _ebeveyn = false.obs;
TextEditingController _veliAdi = TextEditingController();
TextEditingController _veliTel = TextEditingController();

Widget _veliEklePencere({required AnythingVeliData veliData}) {
  return SingleChildScrollView(
    child: Column(children: [
      Text("Yeni Veli Bilgileri", style: TextStyle(fontWeight: FontWeight.bold)),
      Textfield().text(
          controller: _veliAdi,
          onSubmit: (value) {},
          hint: "Veli Ad Soyad",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 10),
      Textfield().text(
          controller: _veliTel,
          onSubmit: (value) {},
          hint: "Veli Telefon Numarası",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Ebeveyn mi?", style: TextStyle()),
        Obx(() => Switch(
            value: _ebeveyn.value,
            onChanged: (value) {
              _ebeveyn.value = value;
            }))
      ]),
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
  // _veliAdi.text = "veli deneme" + Random().nextInt(999).toString();
  // _veliTel.text =
  //     "54629472" + Random().nextInt(9).toString() + Random().nextInt(9).toString();
  // // _veliTel.text="5462947291";

  if (_veliAdi.text == "") {
    toast(msg: "Velinin adını girmelisiniz!");
    return;
  }

  _veliTel.text = _veliTel.text.trim();
  if (!(_veliTel.text.length == 10 || _veliTel.text.length == 11)) {
    toast(msg: "Geçerli telefon numarası giriniz!");
    return;
  }
  Get.context!.loaderOverlay.show();
  ModelKullaniciGetir? veli = await kullaniciGetir(id: veliData.id, token: cp.kullanici.token);
  if (veli == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  }

  //veli ekleniyor
  Map<String, dynamic> body2 = {};
  // body2.addAll({"sinifId": cp.sinif.id});
  body2.addAll({"okulId": cp.okul!.data.id});
  body2.addAll({"adSoyad": _veliAdi.text});
  body2.addAll({"telefon": _veliTel.text});
  body2.addAll({"ebeveynMi": _ebeveyn.value});
  body2.addAll({"veli": "true"});
  body2.addAll({"smsGitsin": "true"});
  body2.addAll({"ogrenciId": veli.data.ogrenciId});

  ModelKullaniciEkleCevap? veli2 = await kullaniciEkle(token: cp.kullanici.token, body: body2);
  if (veli2 == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    Get.context!.loaderOverlay.hide();
    toast(msg: "Öğrenci ve veli eklendi.");
    co.yoneticiVeliGuncelle.value = true;
    Get.back();
  }

  //veli ekleniyor
}
