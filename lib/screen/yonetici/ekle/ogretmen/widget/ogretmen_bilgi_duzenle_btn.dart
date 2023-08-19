import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/text_field.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_getir.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_update.dart';
import 'package:com.powerkidsx/service/kullanici/kullanici_getir.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../helper/locale_gonder.dart';
import '../../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../../service/kullanici/kullanici_push_yetki.dart';
import '../../../../../service/kullanici/kullanici_update_yonetici.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/hata_mesaj.dart';

Widget ogretmenBilgiDuzenleBtn({required AnythingVeliData ogretmenData}) {
  return GestureDetector(
      onTap: () async {
        _sinifList.clear();
        for (int i = 0; i < cp.siniflar.data.length; i++) {
          _sinifList.add(cp.siniflar.data[i].sinifAdi);
        }
        _yetkiGrp = GroupButtonController();
        _sinifGrp = GroupButtonController();
        List<int> yetki = [];
        List<int> sinif = [];
        if (ogretmenData.yetki.veli) {
          yetki.add(0);
        }
        if (ogretmenData.yetki.brans) {
          yetki.add(1);
        }
        if (ogretmenData.yetki.ogretmen) {
          yetki.add(2);
        }
        if (ogretmenData.yetki.admin) {
          yetki.add(3);
        }
        ModelKullaniciGetir? ogretmen =
            await kullaniciGetir(id: ogretmenData.id, token: cp.kullanici.token);
        if (ogretmen == null) {
          toast(msg: "Öğretmen data getirilemedi!");
          return;
        }
        debugPrint(cp.siniflar.data.toString());
        debugPrint(ogretmen.data.sinifId.toString());
        for (int i = 0; i < cp.siniflar.data.length; i++) {
          int index =
              ogretmen.data.sinifId.indexWhere((element) => element == cp.siniflar.data[i].id);
          if (index != -1) {
            sinif.add(i);
          }
        }

        _yetkiGrp = GroupButtonController();
        _yetkiGrp.selectIndexes(yetki);
        _sinifGrp.selectIndexes(sinif);
        Pencere().ac(
            content: _OgretmenKisiselBilgiDuzenle(veliData: ogretmenData),
            context: Get.context!,
            yukseklik: Get.height * 0.75,
            baslik: "Öğretmen Düzenle");
      },
      child: Text(ogretmenData.adSoyad, style: TextStyle()));
}

class _OgretmenKisiselBilgiDuzenle extends StatefulWidget {
  AnythingVeliData veliData;

  _OgretmenKisiselBilgiDuzenle({Key? key, required this.veliData}) : super(key: key);

  @override
  State<_OgretmenKisiselBilgiDuzenle> createState() => _OgretmenKisiselBilgiDuzenleState();
}

TextEditingController _isim = TextEditingController();
TextEditingController _tel = TextEditingController();
TextEditingController _cv = TextEditingController();
TextEditingController _sifre = TextEditingController();
TextEditingController _sifre2 = TextEditingController();
GroupButtonController _yetkiGrp = GroupButtonController();
GroupButtonController _sinifGrp = GroupButtonController();
var _dogumTarihi = DateTime.now().obs;
bool _sifreDegisti = false;
var _dogumDegisti = false.obs;
var _yetkiList = ["Veli", "Branş", "Öğretmen", "Admin"];
var _sinifList = [];

class _OgretmenKisiselBilgiDuzenleState extends State<_OgretmenKisiselBilgiDuzenle> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.veliData.id);
    Get.context!.loaderOverlay.hide();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _isim,
              textRenk: Colors.black,
              hint: "Öğretmen adı soyadı",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _tel,
              textRenk: Colors.black,
              hint: "Telefon No",
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          Textfield().text(
              controller: _cv,
              textRenk: Colors.black,
              hint: "CV",
              minLines: 3,
              maxLines: 5,
              onSubmit: (value) {}),
          SizedBox(width: 0, height: 10),
          GroupButton(
            controller: _yetkiGrp,
            buttons: _yetkiList,
            isRadio: false,
            maxSelected: _yetkiList.length,
          ),
          GroupButton(
            controller: _sinifGrp,
            buttons: _sinifList,
            isRadio: false,
            maxSelected: _sinifList.length,
          ),
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
                Map<String, dynamic> body = {};

                body.addAll({"adSoyad": _isim.text});
                body.addAll({"cv": _cv.text});
                body.addAll({"_id": widget.veliData.id});

                int i = 0;
                for (var element in _sinifGrp.selectedIndexes) {
                  body.addAll({"sinifId[$i]": cp.siniflar.data[element].id});
                  i++;
                }

                ModelKullaniciUpdate? kullanici = await kullaniciUpdateYonetici(
                  token: cp.kullanici.token,
                  body: body,
                );

                if (kullanici == null) {
                  toast(msg: hataMesaj);
                  Get.context!.loaderOverlay.hide();
                  return;
                } else {
                  toast(msg: "Öğretmen bilgileri güncellendi.");
                }

                Map<String, String> body2 = {};
                body2.addAll({"_id": widget.veliData.id});
                //["Veli", "Branş", "Öğretmen", "Admin"]
                String v = "false", b = "false", o = "false", a = "false";
                for (var e in _yetkiGrp.selectedIndexes) {
                  if (e == 0) {
                    v = "true";
                  }
                  if (e == 1) {
                    b = "true";
                  }
                  if (e == 2) {
                    o = "true";
                  }
                  if (e == 3) {
                    a = "true";
                  }
                }
                body2.addAll({"veli": v});
                body2.addAll({"brans": b});
                body2.addAll({"ogretmen": o});
                body2.addAll({"admin": a});
                debugPrint(body2.toString());

                String? ytk = await kullaniciPushYetki(
                  token: cp.kullanici.token,
                  body: body2,
                );

                if (ytk == null) {
                  toast(msg: hataMesaj);
                  Get.context!.loaderOverlay.hide();
                  return;
                } else {
                  toast(msg: "Yetki güncellendi.");
                }

                co.yoneticiOgretmenGuncelle.value = true;
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
    _tel.text = widget.veliData.telefon;
    _cv.text = widget.veliData.cv;
    _sifre = TextEditingController();
    _sifre2 = TextEditingController();
    _dogumTarihi = DateTime.now().obs;
    _sifreDegisti = false;
    _dogumDegisti = false.obs;
  }
}
