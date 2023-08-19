import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../model/web_api/kullanici/kullanici_ekle_cevap.dart';
import '../../../../../service/kullanici/kullanici_ekle.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget yeniOgretmenEkleBtn() {
  return IconButton(
      onPressed: () async {
        _ad = TextEditingController();
        _tel = TextEditingController();
        _sms.value = false;
        _sinifList.clear();
        _yetkiGrp = GroupButtonController();
        _sinifGrp = GroupButtonController();
        for (int i = 0; i < cp.siniflar.data.length; i++) {
          _sinifList.add(cp.siniflar.data[i].sinifAdi);
        }

        Pencere().ac(
            content: _ogretmenEklePencere(),
            context: Get.context!,
            yukseklik: Get.height * 0.55,
            baslik: "Öğretmen Bilgileri");
      },
      icon: const Icon(
        Icons.add,
        color: Colors.blue,
      ));
}

TextEditingController _ad = TextEditingController();
TextEditingController _tel = TextEditingController();
var _sinifList = [];
var _yetkiList = ["Branş", "Öğretmen"];
GroupButtonController _sinifGrp = GroupButtonController();
GroupButtonController _yetkiGrp = GroupButtonController();
var _sms = false.obs;

Widget _ogretmenEklePencere() {
  return SingleChildScrollView(
    child: Column(children: [
      Textfield().text(
          controller: _ad,
          onSubmit: (value) {},
          hint: "Öğretmen Adı Soyadı",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 10),
      Textfield().text(
          controller: _tel,
          onSubmit: (value) {},
          hint: "Öğretmen Telefon Numarası",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 20),
      GroupButton(
        controller: _sinifGrp,
        buttons: _sinifList,
        isRadio: false,
        maxSelected: _sinifList.length,
      ),
      SizedBox(width: 0, height: 20),
      GroupButton(
        controller: _yetkiGrp,
        buttons: _yetkiList,
        isRadio: false,
        maxSelected: _yetkiList.length,
      ),
      SizedBox(width: 0, height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("SMS Gitsin mi?", style: TextStyle()),
        Obx(() => Switch(
            value: _sms.value,
            onChanged: (value) {
              _sms.value = value;
            }))
      ]),
      SizedBox(width: 0, height: 20),
      Buton().mavi(
          click: () {
            _ekle();
          },
          text: "Ekle"),
      SizedBox(width: 0, height: 50),
    ]),
  );
}

Future<void> _ekle() async {
  // _ad.text = "veli"+ Random().nextInt(99999).toString() ;
  // _tel.text =
  //     "54629472" + Random().nextInt(9).toString() + Random().nextInt(9).toString();
  // // _veliTel.text="5462947291";

  if (_ad.text == "") {
    toast(msg: "Bir isim girmelisiniz!");
    return;
  }

  _tel.text = _tel.text.trim();
  if (!(_tel.text.length == 10 || _tel.text.length == 11)) {
    toast(msg: "Geçerli bir telefon girmelisiniz!");
    return;
  }

  //veli ekleniyor
  Map<String, dynamic> body = {};

  body.addAll({"okulId": cp.okul!.data.id});
  body.addAll({"adSoyad": _ad.text});
  body.addAll({"telefon": _tel.text});
  body.addAll({"smsGitsin": _sms.value});
  body.addAll({"veli": "false"});
  bool brans = false, ogretmen = false;
  for (var e in _yetkiGrp.selectedIndexes) {
    if (e == 0) {
      body.addAll({"brans": "true"});
      brans = true;
    }
    if (e == 1) {
      body.addAll({"ogretmen": "true"});
      ogretmen = true;
    }
  }
  if (brans == false) body.addAll({"brans": "false"});
  if (ogretmen == false) body.addAll({"ogretmen": "false"});
  if (brans == false && ogretmen == false) {
    toast(msg: "Bir yetki seçmelisiniz!");
    return;
  }
  int i = 0;
  List<String> sinif = [];
  for (var element in _sinifGrp.selectedIndexes) {
    // body.addAll({"sinifId[$i]": cp.siniflar.data[element].id});
    sinif.add(cp.siniflar.data[element].id);
    i++;
  }
  if (sinif.isEmpty) {
    toast(msg: "Sınıf seçmelisiniz!");
    return;
  }
  body.addAll({"sinifId": sinif});

  debugPrint(body.toString());
  // return;
  Get.context!.loaderOverlay.show();
  ModelKullaniciEkleCevap? veli = await kullaniciEkle(token: cp.kullanici.token, body: body);
  if (veli == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    co.yoneticiOgretmenGuncelle.value = true;
    toast(msg: "Kullanıcı eklendi.");
  }
  Get.context!.loaderOverlay.hide();
  Get.back();
  //veli ekleniyor
}
