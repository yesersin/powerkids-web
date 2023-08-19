import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/helper/sayfalari_temizle.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../component/pencere/evet_hayir.dart';
import '../../../login/yetki_sec_sayfa.dart';
import '../../../static/geri_boolean.dart';
import '../anasayfa/ogretmen_anasayfa_giris.dart';
import '../profil/ogretmen_profil_giris.dart';
import 'anasayfa_title_temizle.dart';

Future<bool> geriBtnClick(
    {required COgretmen c, required PersistentTabController tabController}) async {
  if (c.bildirimSayfasi.value) {
    c.bildirimSayfasi.value = false;
    sayfalariTemizle(c: c);
    return false;
  }
  // return true; olursa çıkar
  //anasayfada geri tuşuna basıldığında

  if (c.sayfaSecilenIndex.value == 0) {
    // debugPrint("x0");
    if (c.anasayfaSayfalari.length > 1) {
      // debugPrint("x1");
      geri = false;
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.anasayfaSayfalari.removeLast();
      c.ogretmenSayfalar[0] = c.anasayfaSayfalari.last;
      if (c.anasayfaSayfalari.length == 1) {
        // debugPrint("x2");
        anasayfaTitleTemizle(c: c);
      }
      // debugPrint("x3");
      return false;
    } else {
      // debugPrint("x4");
      c.ogretmenSayfalar[0] = OgretmenAnasayfaGiris();
      anasayfaTitleTemizle(c: c);
      if (geri == false) {
        geri = true;
        return false;
      }
      // if (c.anasayfaSayfalari.length == 1) {
      //   debugPrint("x5");
      //   return false;
      // }
      // debugPrint("x6");
    }
  }

  if (c.sayfaSecilenIndex.value == 4) {
    //profilde geri tuşuna basıldığında
    if (c.profilSayfalari.length > 1) {
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.profilSayfalari.removeLast();
      c.ogretmenSayfalar[4] = c.profilSayfalari.last;
      return false;
    } else {
      // print("sayı:" + c.profilSayfalari.length.toString());
      c.ogretmenSayfalar[4] = OgretmenProfilGiris();
      if (c.profilSayfalari.length != 1) return false;
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
