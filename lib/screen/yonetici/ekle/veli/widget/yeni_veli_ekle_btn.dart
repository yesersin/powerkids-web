import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../helper/ogrenci_sayisi.dart';
import '../../../../../model/web_api/kullanici/kullanici_ekle_cevap.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_ekle_cevap.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_sayisi.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../service/kullanici/kullanici_ekle.dart';
import '../../../../../service/ogrenci/ogrenci_ekle.dart';
import '../../../../../service/ogrenci/ogrenci_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget yeniVeliEkleBtn() {
  return IconButton(
      onPressed: () async {
        ModelOgrenciSayisi? sayi = await ogrenciSayisiYukle();
        if (sayi == null) {
          toast(msg: "Öğrenci kontejan bilgisi gelmedi!");
          return;
        } else if ((sayi.data.fark < 1)) {
          toast(msg: "Kontenjan doldu. Lütfen iletişime geçin!”");
          return;
        }
        _ogrenciAdi = TextEditingController();
        _veliAdi = TextEditingController();
        // _veliEmail = TextEditingController();
        _veliTel = TextEditingController();
        _sms.value = true;
        _sinifList.clear();
        for (int i = 0; i < cp.siniflar.data.length; i++) {
          _sinifList.add(cp.siniflar.data[i].sinifAdi);
        }
        _sinifGrp.selectIndex(0);

        Pencere().ac(
            content: _veliEklePencere(), context: Get.context!, yukseklik: Get.height * 0.65);
      },
      icon: Icon(
        Icons.add,
        color: Colors.green,
      ));
}

TextEditingController _ogrenciAdi = TextEditingController();
TextEditingController _veliAdi = TextEditingController();
// TextEditingController _veliEmail = TextEditingController();
TextEditingController _veliTel = TextEditingController();
GroupButtonController _sinifGrp = GroupButtonController();
var _sinifList = [];
var _sms = false.obs;

Widget _veliEklePencere() {
  return SingleChildScrollView(
    child: Column(children: [
      Text("Öğrenci Bilgileri", style: TextStyle(fontWeight: FontWeight.bold)),

      SizedBox(width: 0, height: 10),
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
      Divider(height: 2, color: Color.fromARGB(255, 201, 201, 201)),
      SizedBox(width: 0, height: 25),
      Text("Veli Bilgileri", style: TextStyle(fontWeight: FontWeight.bold)),

      Textfield().text(
          controller: _veliAdi,
          onSubmit: (value) {},
          hint: "Veli Ad Soyad",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
      SizedBox(width: 0, height: 10),
      // Textfield().text(
      //     controller: _veliEmail,
      //     onSubmit: (value) {},
      //     hint: "Veli Email Adresi",
      //     minLines: 1,
      //     maxLines: 1,
      //     textRenk: Colors.black),
      // SizedBox(width: 0, height: 10),
      Textfield().text(
          controller: _veliTel,
          onSubmit: (value) {},
          hint: "Veli Telefon Numarası",
          minLines: 1,
          maxLines: 1,
          textRenk: Colors.black),
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
  // _ogrenciAdi.text = "öğrenci dsd";
  // _veliAdi.text = "veli dsd";
  // _veliEmail.text="dsd@q.com";
  // _veliTel.text =
  //     "54629472" + Random().nextInt(9).toString() + Random().nextInt(9).toString();
  // // _veliTel.text="5462947291";
  if (_ogrenciAdi.text == "") {
    toast(msg: "Öğrenci adı girmelisiniz!");
    return;
  }
  if (_veliAdi.text == "") {
    toast(msg: "Veli adı girmelisiniz!");
    return;
  }
  // _veliEmail.text=_veliEmail.text.trim();
  // if(!_veliEmail.text.isEmail){
  //   toast(msg: "Geçerli bir email adresi girmelisiniz!");
  //   return;
  // }
  _veliTel.text = _veliTel.text.trim();
  if (!(_veliTel.text.length == 10 || _veliTel.text.length == 11)) {
    toast(msg: "Geçerli bir telefon girmelisiniz!");
    return;
  }
  Get.context!.loaderOverlay.show();
  //öğrenci ekleniyor
  String sinifId = cp.siniflar.data[_sinifGrp.selectedIndex ?? 0].id;
  Map<String, String> body = {};
  body.addAll({"sinifId": sinifId});
  body.addAll({"okulId": cp.okul!.data.id});
  body.addAll({"adSoyad": _ogrenciAdi.text});
  debugPrint("1");
  ModelOgrenciEkleCevap? ogrenci = await ogrenciEkle(
    token: cp.kullanici.token,
    body: body,
  );
  debugPrint("2");
  if (ogrenci == null) {
    debugPrint("3");
    toast(msg: hataMesaj);
    Get.context!.loaderOverlay.hide();
    return;
  }
  debugPrint("4");
  //öğrenci ekleniyor
  //veli ekleniyor
  Map<String, dynamic> body2 = {};
  // body2.addAll({"sinifId": cp.sinif.id});
  body2.addAll({"okulId": cp.okul!.data.id});
  body2.addAll({"adSoyad": _veliAdi.text});
  body2.addAll({"telefon": _veliTel.text});
  body2.addAll({"smsGitsin": _sms.value.toString()});
  body2.addAll({"veli": "true"});
  body2.addAll({
    "ogrenciId": [ogrenci.data.id]
  });

  ModelKullaniciEkleCevap? veli = await kullaniciEkle(token: cp.kullanici.token, body: body2);
  if (veli == null) {
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
    co.yoneticiVeliGuncelle.value = true;
    co.yoneticiOgrenciGuncelle.value = true;

    toast(msg: "Öğrenci ve veli eklendi.");
    Get.back();
  }
  Get.context!.loaderOverlay.hide();
  //veli ekleniyor
}
