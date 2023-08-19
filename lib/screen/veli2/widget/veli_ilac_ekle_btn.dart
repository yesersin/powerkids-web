import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../component/custom/button.dart';
import '../../../component/custom/text_field.dart';
import '../../../component/pencere/uyari_pencere.dart';
import '../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../helper/tarih.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/ilac/ilac_ekle_cevap.dart';
import '../../../model/web_api/kullanici/kullanici_notification.dart';
import '../../../service/kullanici/kullanici_get_notification_list.dart';
import '../../../service/ogrenci/ogrenci_ilac_ekle.dart';
import '../../../static/cogretmen.dart';
import '../../../static/hata_mesaj.dart';

Widget veliIlacEkleBtn({required COgretmen c}) {
  return Stack(
    children: [
      IconButton(
          onPressed: () async {
            _ilac_pencere();
          },
          icon: Icon(
            Icons.add,
            color: Colors.red,
          )),
    ],
  );
}

void _ilac_pencere() {
  TextEditingController not = TextEditingController(text: "");
  TextEditingController ilacadi = TextEditingController(text: "");
  String tarih = Tarih().gunAyYil(co.secilenTarih.value);
  Pencere().ac(
      content: Column(
        children: [
          Text("Tarih:" + tarih, style: TextStyle()),
          SizedBox(width: 0, height: 5),
          Row(children: [
            Expanded(
              child: Textfield().text(
                hint: "İlaç Adı",
                textRenk: Colors.black,
                controller: ilacadi,
                onSubmit: (text) {},
              ),
            ),
          ]),
          SizedBox(width: 0, height: 5),
          Row(children: [
            Expanded(
              child: Textfield().text(
                hint: "Açıklama",
                textRenk: Colors.black,
                controller: not,
                onSubmit: (text) {},
                minLines: 5,
                maxLines: 7,
              ),
            ),
          ]),
          SizedBox(width: 0, height: 5),
          MaterialButton(
              onPressed: () async {
                TimeOfDay? saat = await showTimePicker(
                  context: Get.context!,
                  initialTime:
                      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child ?? SizedBox(width: 0, height: 0),
                    );
                  },
                );
                if (saat == null) {
                  co.veliIlacEkleSaat.value = TimeOfDay.now();
                } else {
                  co.veliIlacEkleSaat.value = saat;
                }
              },
              child:
                  Obx(() => Text("Saat:" + Tarih().saatDkTimeOf(co.veliIlacEkleSaat.value)))),
          SizedBox(width: 0, height: 5),
          Buton().mavi(
              click: () async {
                if (not.text.isEmpty || ilacadi.text.isEmpty) {
                  toast(msg: "Lütfen bilgileri giriniz.");
                  return;
                }

                Get.context!.loaderOverlay.show();
                //ilaç eklenecek öğretmeni bul
                String ogretmenId, ogretmenAd;
                ModelKullaniciNotification? list = await getKullaniciNotificationList(
                    sinifId: cp.sinif.id,
                    okulId: cp.okul!.data.id,
                    token: cp.kullanici.token,
                    ogretmen: true);
                if (list != null) {
                  ogretmenId = list.data.first.id;
                  ogretmenAd = list.data.first.adSoyad;
                } else {
                  ogretmenId = "null";
                  ogretmenAd = "null";
                }
                //ilaç eklenecek öğretmeni bul

                Map<String, String> body = {};
                body.addAll({"sinifId": cp.sinif.id});
                body.addAll({"ogrenciId": co.veliSecilenOgrenci.value.data.id});
                body.addAll({"ogrenciAdSoyad": co.veliSecilenOgrenci.value.data.adSoyad});
                body.addAll({"veliId": cp.kullanici.data.id});
                body.addAll({"veliAdSoyad": cp.kullanici.data.adSoyad});
                body.addAll({"ogretmenId": ogretmenId});
                body.addAll({"ogretmenAdSoyad": ogretmenAd});
                body.addAll({"not": not.text});
                body.addAll({"ilacAdi": ilacadi.text});
                body.addAll({"yil": co.secilenTarih.value.year.toString()});
                body.addAll({"ay": co.secilenTarih.value.month.toString()});
                body.addAll({"gun": co.secilenTarih.value.day.toString()});
                body.addAll({"saat": co.veliIlacEkleSaat.value.hour.toString()});
                body.addAll({"dil": cp.dil});
                debugPrint("body:" + body.toString());
                ModelIlacEkleCevap? ilac = await ogrenciIlacEkle(
                  token: cp.kullanici.token,
                  body: body,
                );
                if (ilac == null) {
                  toast(msg: hataMesaj);
                  Get.context!.loaderOverlay.hide();
                  return;
                }
                String etkinlikId = ilac.data.id;
                debugPrint("eklenen ilaç id:" + ilac.data.id);
                String mesaj = co.veliSecilenOgrenci.value.data.adSoyad +
                    " öğrenci ilaç kullanımı" +
                    ilac.data.id;
                bool pushBildirim = false;
                int fark = co.secilenTarih.value.compareTo(DateTime.now());
                if (fark <= 2) {
                  pushBildirim = true;
                }
                listeBildirimGonder(
                  tip: "1",
                  //evet hayır tip
                  etkinlikId: etkinlikId,
                  ogretmen: true,
                  body: mesaj,
                  pushBildirim: pushBildirim,
                );
                Get.context!.loaderOverlay.hide();
                Get.back();
              },
              text: "Ekle"),
        ],
      ),
      yukseklik: 400,
      context: Get.context!);
}
