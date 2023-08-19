import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/custom/button.dart';
import '../../../component/custom/text_field.dart';
import '../../../component/pencere/uyari_pencere.dart';
import '../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../helper/tarih.dart';
import '../../../helper/toast.dart';
import '../../../static/cogretmen.dart';

Widget veliYoklamaEkleBtn({required COgretmen c}) {
  return Stack(
    children: [
      IconButton(
          onPressed: () async {
            pencere();
          },
          icon: Icon(Icons.add)),
    ],
  );
}

void pencere() {
  TextEditingController aciklama = TextEditingController(text: "açıklama");
  String tarih = Tarih().gunAyYil(co.secilenTarih.value);
  Pencere().ac(
      content: Column(
        children: [
          Text("Tarih:" + tarih, style: TextStyle()),
          SizedBox(width: 0, height: 5),
          Row(children: [
            Expanded(
              child: Textfield().text(
                hint: "Açıklama",
                textRenk: Colors.black,
                controller: aciklama,
                onSubmit: (text) {},
              ),
            ),
          ]),
          SizedBox(width: 0, height: 5),
          Buton().mavi(
              click: () async {
                if (aciklama.text.isEmpty) {
                  toast(msg: "Lütfen bilgileri doldurunuz.");
                  return;
                }

                String mesaj = "Öğrenci " +
                    co.veliSecilenOgrenci.value.data.adSoyad +
                    " " +
                    Tarih().gunAyYil(co.secilenTarih.value) +
                    " tarihinde okula gelmeyecektir. Velisi " +
                    cp.kullanici.data.adSoyad +
                    ": " +
                    aciklama.text;
                debugPrint(mesaj);
                bool pushBildirim = false;
                int fark = co.secilenTarih.value.compareTo(DateTime.now());
                if (fark <= 2) {
                  pushBildirim = true;
                }
                listeBildirimGonder(
                  tip: "16",
                  ogretmen: true,
                  body: mesaj,
                  pushBildirim: pushBildirim,
                );
              },
              text: "Ekle"),
        ],
      ),
      context: Get.context!);
}
