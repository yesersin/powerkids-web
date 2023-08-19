import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:location/location.dart';

import '../../../../const/okula_geliyorum.dart';
import '../../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../../helper/izin.dart';
import '../../../../helper/mesafe_hesapla.dart';
import '../../../../helper/toast.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';

Future<void> okulaGidiyorum() async {
  bool izin = await Izin().konum();
  if (izin == false) {
    toast(msg: "Bu özelliği kullanabilmek için konum erişim izni vermeniz gerekir!");
    return;
  }
  String sonuc = "";
  await Pencere().ac(
      yukseklik: 120,
      content: Column(children: [
        Text("Nasıl gideceksiniz?", style: TextStyle()),
        MaterialButton(
            onPressed: () {
              sonuc = OkulaGeliyorumTip.araba;
              Get.back();
            },
            child: Text("Arabayla")),
        MaterialButton(
            onPressed: () {
              sonuc = OkulaGeliyorumTip.yurume;
              Get.back();
            },
            child: Text("Yürüyerek")),
      ]),
      context: Get.context!,
      baslik: "Okula Geliyorum");
  if (sonuc == "") return; //seçim yok
  Get.context!.loaderOverlay.hide();
  Get.context!.loaderOverlay.show();
  Location location = Location();
  LocationData data = await location.getLocation();
  debugPrint(data.toString());
  // cp.okul!.data.adres.lat = 37.4220936; //geçici
  // cp.okul!.data.adres.lng = -122.083922; //geçici
  double mesafe = mesafeHesapla(
    lat1: data.latitude!.toDouble(),
    lon1: data.longitude!.toDouble(),
    lat2: cp.okul!.data.adres.lat,
    lon2: cp.okul!.data.adres.lng,
  );
  //Yürüyerek(4km/sa), Arba(50km/sa) ile diye sorulur.
  // Yürüyerek 30dk araç ile 50dk üzerindeyse
  double hiz = 0;
  if (sonuc == OkulaGeliyorumTip.yurume) {
    hiz = 4;
  } else {
    hiz = 50;
  }
  mesafe = mesafe / 1000; //m to km
  double sure = mesafe / hiz * 60; //dakika
  debugPrint("süre:" + sure.toString());
  if ((hiz == 4 && sure > 30) || (hiz == 50 && sure > 50)) {
    toast(msg: "Mesafe çok uzak!");
    debugPrint("Mesafe çok uzak!");
    Get.context!.loaderOverlay.hide();
    return;
  }

  debugPrint("işlem yapılıyor");
  //Öğrenci Defne Yeşersin velisi Erkan Yeşersin 12dk sonra öğrencisini
  String mesaj = "Öğrenci" + co.veliSecilenOgrenci.value.data.adSoyad;
  mesaj += " velisi " + cp.kullanici.data.adSoyad + " ";
  mesaj += sure.toInt().toString() + " dk sonra öğrencisini almak üzere okulda olacak.";
  debugPrint("mesaj:" + mesaj);
  listeBildirimGonder(tip: "2", body: mesaj, pushBildirim: true);
  toast(msg: mesaj);

  Get.context!.loaderOverlay.hide();
  return;
}
