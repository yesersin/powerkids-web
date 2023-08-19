import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/veli2/helper/sayfalari_temizle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../component/pencere/evet_hayir.dart';
import '../../../login/yetki_sec_sayfa.dart';
import '../../../static/geri_boolean.dart';
import '../anasayfa/veli_anasayfa_giris.dart';
import '../profil/veli_ogrenci_profil_giris.dart';
import 'anasayfa_title_temizle.dart';

Future<bool> veliGeriBtnClick(
    {required COgretmen c, required PersistentTabController tabController}) async {
  c.veliYoklamaSayfaEkleBtn.value = false;
  c.veliIlacSayfaEkleBtn.value = false;
  if (c.bildirimSayfasi.value) {
    c.bildirimSayfasi.value = false;
    veliSayfalariTemizle(c: c);
    return false;
  }

  // return true; olursa çıkar
  //anasayfada geri tuşuna basıldığında

  if (c.sayfaSecilenIndex.value == 0) {
    // debugPrint("x0");
    if (c.veliAnasayfaSayfalari.length > 1) {
      // debugPrint("x1");
      geri = false;
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.veliAnasayfaSayfalari.removeLast();
      c.veliSayfalar[0] = c.veliAnasayfaSayfalari.last;
      if (c.veliAnasayfaSayfalari.length == 1) {
        // debugPrint("x2");
        anasayfaTitleTemizle(c: c);
      }
      // debugPrint("x3");
      return false;
    } else {
      // debugPrint("x4");
      c.veliSayfalar[0] = VeliAnasayfaGiris();
      anasayfaTitleTemizle(c: c);
      if (geri == false) {
        geri = true;
        return false;
      }
      // if (c.veliAnasayfaSayfalari.length == 1) {
      //   debugPrint("x5");
      //   return false;
      // }
      // debugPrint("x6");
    }
  }

  if (c.sayfaSecilenIndex.value == 2) {
    //profilde geri tuşuna basıldığında
    if (c.veliProfilSayfalari.length > 1) {
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.veliProfilSayfalari.removeLast();
      c.veliSayfalar[2] = c.veliProfilSayfalari.last;

      return false;
    } else {
      // print("sayı:" + c.veliProfilSayfalari.length.toString());
      c.veliSayfalar[2] = VeliOgrenciProfilGiris();
      if (c.veliProfilSayfalari.length != 1) return false;
    }
  }
  debugPrint("x9");
  bool cevap = await PencereEvetHayir().sor(baslik: "Çıkmak istiyor musunuz?");
  if (cevap) {
    tabController =
        PersistentTabController(initialIndex: 0); //öğretmene gelirse, başlangıç olsun
    c.sayfaSecilenIndex.value = 0;
    Get.off(() => LoginYetkiSecSayfa());
  }
  return cevap;
}
