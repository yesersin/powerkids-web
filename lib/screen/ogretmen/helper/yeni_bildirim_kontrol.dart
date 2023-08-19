import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/cupertino.dart';

void yeniBildirimKontrol() {
  debugPrint("yeni bildirim kontrol");
  // cp.kullanici.data.sonGirisTarihi = cp.kullanici.data.sonGirisTarihi.subtract(Duration(days: 100)); //geçici
  cp.bildirimSayisi.value = 0;
  if (cp.bildirimler == null) {
    cp.bildirimSayisi.value = 0;
    return;
  }
  for (int i = 0; i < cp.bildirimler!.data.length; i++) {
    if (cp.kullanici.data.sonGirisTarihi.isAfter(cp.bildirimler!.data[i].zaman)) {
      // debugPrint("yeni bildirim:" + cp.bildirimler!.data[i].mesaj);
      cp.bildirimSayisi.value++;
    }
  }
  debugPrint("bildirim sayısı:" + cp.bildirimSayisi.value.toString());
}
