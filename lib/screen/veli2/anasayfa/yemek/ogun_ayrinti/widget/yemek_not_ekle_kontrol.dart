import 'package:com.powerkidsx/service/yemek_not/yemek_not_add.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../component/custom/button.dart';
import '../../../../../../component/custom/text_field.dart';
import '../../../../../../component/pencere/evet_hayir.dart';
import '../../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../../helper/toast.dart';
import '../../../../../../model/web_api/veli/veli_yemek_not.dart';
import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/cprogram.dart';

TextEditingController yemekNot = TextEditingController();

Future<void> yemekNotEkleKontrol(
    {required ModelVeliYemekNot? not, required String ogun}) async {
  if (not == null) {
    _notYok(ogun: ogun);
  } else {
    _notVar(not: not);
  }
}

Future<void> _notYok({required String ogun}) async {
  yemekNot = TextEditingController();
  Pencere().ac(
      baslik: "Yemek Not",
      yukseklik: 200,
      content: Column(children: [
        Row(
          children: [
            Expanded(
              child: Textfield().text(
                controller: yemekNot,
                hint: "Not girin",
                textRenk: Colors.black,
                maxLines: 6,
                minLines: 2,
                onSubmit: (text) {},
              ),
            ),
          ],
        ),
        SizedBox(width: 0, height: 10),
        Buton().mavi(
            click: () async {
              if (yemekNot.text.length < 5) {
                toast(msg: "Yemek notunuz en az 5 karakter olmalıdır.");
                return;
              }
              bool cevap = await PencereEvetHayir().sor(baslik: "Not eklensin mi?");
              if (cevap == false) return;
              Get.context!.loaderOverlay.show();
              bool cevap2 = await veliYemekNotAdd(
                  yil: co.yemekSecilenTarih.value.year.toString(),
                  gun: co.yemekSecilenTarih.value.day.toString(),
                  ay: co.yemekSecilenTarih.value.month.toString(),
                  not: yemekNot.text,
                  ogun: ogun,
                  dil: cp.dil,
                  okulId: co.veliSecilenOgrenci.value.data.okulId,
                  ogrenciId: co.veliSecilenOgrenci.value.data.id,
                  veliId: cp.kullanici.data.id,
                  veliAdSoyad: cp.kullanici.data.adSoyad,
                  ogrenciAdSoyad: co.veliSecilenOgrenci.value.data.adSoyad,
                  sinifId: co.veliSecilenOgrenci.value.data.sinifId,
                  token: cp.kullanici.token);
              Get.context!.loaderOverlay.hide();
              if (cevap2) {
                toast(msg: "Not eklendi!");
                Get.back();
              } else {
                toast(msg: hataMesaj);
              }
            },
            text: "Tamam"),
      ]),
      context: Get.context!);
}

Future<void> _notVar({required ModelVeliYemekNot not}) async {
  yemekNot = TextEditingController();
  Pencere().ac(
      baslik: "Yemek Not",
      yukseklik: 200,
      content: Column(children: [
        Row(
          children: [
            Expanded(
              child: Text(not.data.first.not, style: TextStyle()),
            ),
          ],
        ),
        if (not.data.first.goruldu) OutlinedButton(onPressed: () {}, child: Text("Görüldü")),
        SizedBox(width: 0, height: 10),
        // Buton().mavi(
        //     click: ()async {
        //       ModelVeliYemekNotUpdateCevap? cevap = await veliYemekNotUpdate(
        //           token: cp.kullanici.token,
        //           body: {"_id": not.data.first.id, "durum": "false"});
        //       if(cevap==null){
        //         toast(msg: hataMesaj);
        //       }else{
        //         toast(msg: "Not silindi!");
        //       }
        //
        //       Get.back();
        //     },
        //     text: "Sil"),
      ]),
      context: Get.context!);
}
