import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_update.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../helper/locale_gonder.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../../service/kullanici/kullanici_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/hata_mesaj.dart';

Widget veliBilgiDuzenleBtn({required AnythingVeliData veliData}) {
  return GestureDetector(
      onTap: () {
        Pencere().ac(
            content: _VeliKisiselBilgiDuzenle(veliData: veliData),
            context: Get.context!,
            yukseklik: Get.height * 0.5,
            baslik: "Veli Düzenle");
      },
      child: Text(veliData.adSoyad, style: TextStyle()));
}

class _VeliKisiselBilgiDuzenle extends StatefulWidget {
  AnythingVeliData veliData;

  _VeliKisiselBilgiDuzenle({Key? key, required this.veliData}) : super(key: key);

  @override
  State<_VeliKisiselBilgiDuzenle> createState() => _VeliKisiselBilgiDuzenleState();
}

TextEditingController _isim = TextEditingController();
TextEditingController _telefon = TextEditingController();
TextEditingController _sifre = TextEditingController();
TextEditingController _sifre2 = TextEditingController();
var _dogumTarihi = DateTime.now().obs;
bool _sifreDegisti = false;
var _dogumDegisti = false.obs;

class _VeliKisiselBilgiDuzenleState extends State<_VeliKisiselBilgiDuzenle> {
  @override
  Widget build(BuildContext context) {
    Get.context!.loaderOverlay.hide();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _isim,
              textRenk: Colors.black,
              hint: "Veli Ad Soyad",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _telefon,
              textRenk: Colors.black,
              hint: "Veli Telefonu",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          MaterialButton(
            onPressed: () async {
              DateTime? tarih = await showDatePicker(
                context: context,
                initialDate: DateTime.now().subtract(Duration(days: 11000)),
                firstDate: DateTime.now().subtract(Duration(days: 37550)),
                lastDate: DateTime.now(),
                locale: getLocale(dil: cp.dil),
              );
              if (tarih == null) {
                debugPrint("seçilmedi");
              } else {
                _dogumDegisti.value = true;
                _dogumTarihi.value = tarih;
              }
            },
            child: Obx(
              () => Text(_dogumDegisti.value
                  ? ("Seçilen Tarih:" + Tarih().gunAyYil(_dogumTarihi.value))
                  : "Doğum Tarihi Değiştir"),
            ),
          ),
          Text("Şifre Değiştir"),
          Textfield().text(
              controller: _sifre,
              textRenk: Colors.black,
              hint: "Şifreyi girin",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _sifre2,
              textRenk: Colors.black,
              hint: "Şifreyi tekrar girin",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          Buton().mavi(
              click: () async {
                Get.context!.loaderOverlay.show();
                Map<String, String> body = {};
                // if (yeniIsim.text.length < 4) {
                //   toast(msg: "İsim en az 4 karakter olmalıdır.");
                //   return;
                // }
                //

                if (_sifreDegisti) {
                  debugPrint("şifre eklendi");
                  body.addAll({"sifre": _sifre.text});
                }
                if (_dogumDegisti.value) {
                  debugPrint("dogum eklendi");
                  body.addAll({"dogumTarihi": _dogumTarihi.value.toIso8601String()});
                }

                debugPrint("isim eklendi");
                body.addAll({"adSoyad": _isim.text});
                body.addAll({"telefon": _telefon.text});

                body.addAll({"_id": widget.veliData.id});

                ModelKullaniciUpdate? kullanici = await kullaniciUpdate(
                  token: cp.kullanici.token,
                  body: body,
                );
                debugPrint("isim eklendi:" + kullanici.toString());

                if (kullanici == null) {
                  toast(msg: hataMesaj);
                } else {
                  // cp.kullanici.data = kullanici.data.kullaniciDataDonustur();
                  toast(msg: "Veli bilgileri güncellendi.");
                }

                co.yoneticiVeliGuncelle.value = true;
                Get.context!.loaderOverlay.hide();
                Get.back();
              },
              text: "Kaydet"),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("kişisel giriş init");
    _isim.text = widget.veliData.adSoyad;
    _telefon.text = widget.veliData.telefon;
    _sifre = TextEditingController();
    _sifre2 = TextEditingController();
    _dogumTarihi = DateTime.now().obs;
    _sifreDegisti = false;
    _dogumDegisti = false.obs;
  }
}
