import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/profil_sayfasi/widget/yuvarlak.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../component/custom/button.dart';
import '../../../../../../component/custom/text_field.dart';
import '../../../../../../const/renk.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_etklinlik_up_cevap.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_karti.dart';
import '../../../../../../service/ogrenci/ogrenci_kart_up_diger.dart';
import '../../../../../../static/cprogram.dart';
import '../../../../../../static/hata_mesaj.dart';

Widget boy({required ModelOgrenciKarti kart}) {
  Get.context!.loaderOverlay.hide();

  return yuvarlak(
      sayi: kart.data.boykilo.last.boy.toString(),
      altMetin: "Boy",
      renk: Renk.kirmizi,
      komut: () {
        TextEditingController boy = TextEditingController(text: "");
        TextEditingController kilo = TextEditingController(text: "");
        Pencere().ac(
            content: Column(
              children: [
                Text("Tarih:" + Tarih().gunAyYil(DateTime.now()), style: TextStyle()),
                SizedBox(width: 0, height: 5),
                Row(children: [
                  Expanded(
                    child: Textfield().text(
                      hint: "Boy",
                      textRenk: Colors.black,
                      controller: boy,
                      onSubmit: (text) {},
                    ),
                  ),
                ]),
                SizedBox(width: 0, height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Textfield().text(
                        hint: "Kilo",
                        textRenk: Colors.black,
                        controller: kilo,
                        onSubmit: (text) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 0, height: 5),
                Buton().mavi(
                    click: () async {
                      if (boy.text.isEmpty || kilo.text.isEmpty) {
                        toast(msg: "Lütfen bilgileri giriniz.");
                        return;
                      }
                      if (!boy.text.isNumericOnly || !kilo.text.isNumericOnly) {
                        toast(msg: "Lütfen sayı giriniz.");
                        return;
                      }
                      int b = int.parse(boy.text);
                      int k = int.parse(kilo.text);
                      if ((k < 6 || k > 40) || (b < 30 || b > 130)) {
                        toast(msg: "Kilo 6-40 arasında, boy 30-130 arasında olmalıdır.");
                        return;
                      }

                      Map<String, dynamic> body = {
                        "boykilo": {
                          "boy": boy.text,
                          "kilo": kilo.text,
                          "ekleyenId": cp.kullanici.data.id,
                        }
                      };

                      Get.context!.loaderOverlay.show();
                      ModelOgrenciEtkinlikUpCevap? sonuc = await ogrenciKartUpDiger(
                        okulId: kart.data.okulId,
                        ogrenciId: kart.data.ogrenciId,
                        token: cp.kullanici.token,
                        kartId: kart.data.id,
                        body: body,
                      );
                      if (sonuc == null) {
                        Get.context!.loaderOverlay.hide();
                        toast(msg: hataMesaj);
                        return;
                      } else {
                        toast(msg: "Bilgiler eklendi.");
                        kart.data.boykilo.add(Boykilo(
                            boy: int.parse(boy.text),
                            kilo: int.parse(kilo.text),
                            ekleyenId: "",
                            durum: true,
                            id: "id",
                            tarih: DateTime.now()));
                        Get.back();
                      }
                      Get.context!.loaderOverlay.hide();
                    },
                    text: "Ekle"),
              ],
            ),
            context: Get.context!);
      });
}
