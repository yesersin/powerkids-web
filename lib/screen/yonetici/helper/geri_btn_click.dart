import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/yonetici/helper/sayfalari_temizle.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../component/pencere/evet_hayir.dart';
import '../../../login/yetki_sec_sayfa.dart';
import '../../../static/geri_boolean.dart';
import '../anasayfa/anasayfa_giris.dart';
import '../ekle/ekle_giris.dart';
import '../profil/yonetici_profil_giris.dart';
import 'anasayfa_title_temizle.dart';

Future<bool> geriBtnClick(
    {required COgretmen c, required PersistentTabController tabController}) async {
  if (c.bildirimSayfasi.value) {
    c.bildirimSayfasi.value = false;
    sayfalariTemizle(c: c);
    return false;
  }

  if (c.sayfaSecilenIndex.value == 0) {
    if (c.yoneticiAnasayfaSayfalari.length > 1) {
      geri = false;
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.yoneticiAnasayfaSayfalari.removeLast();
      c.yoneticiSayfalar[0] = c.yoneticiAnasayfaSayfalari.last;
      if (c.yoneticiAnasayfaSayfalari.length == 1) {
        anasayfaTitleTemizle(c: c);
      }
      return false;
    } else {
      c.yoneticiSayfalar[0] = YoneticiAnasayfaGiris();
      anasayfaTitleTemizle(c: c);
      if (geri == false) {
        geri = true;
        return false;
      }
    }
  }
  if (c.sayfaSecilenIndex.value == 1) {
    c.yoneticiVeliEkle.value = false;
    c.yoneticiOgretmenEkle.value = false;
    c.yoneticiDuyuruEkle.value = false;
    if (c.yoneticiEkleSayfalari.length > 1) {
      geri = false;
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.yoneticiEkleSayfalari.removeLast();
      c.yoneticiSayfalar[1] = c.yoneticiEkleSayfalari.last;
      if (c.yoneticiEkleSayfalari.length == 1) {
        anasayfaTitleTemizle(c: c);
      }
      return false;
    } else {
      c.yoneticiSayfalar[1] = YoneticiEkleGiris();

      anasayfaTitleTemizle(c: c);
      if (geri == false) {
        geri = true;
        return false;
      }
    }
  }
  if (c.sayfaSecilenIndex.value == 4) {
    //profilde geri tuşuna basıldığında
    if (c.yoneticiProfilSayfalari.length > 1) {
      //2.sayfadan sonrasında geri tuşuna basıldığında
      c.yoneticiProfilSayfalari.removeLast();
      c.yoneticiSayfalar[4] = c.yoneticiProfilSayfalari.last;
      return false;
    } else {
      // print("sayı:" + c.profilSayfalari.length.toString());
      c.yoneticiSayfalar[4] = YoneticiProfilGiris();
      if (c.yoneticiProfilSayfalari.length != 1) return false;
    }
  }
  bool cevap = await PencereEvetHayir().sor(baslik: "Çıkmak istiyor musunuz?");
  if (cevap) {
    tabController =
        PersistentTabController(initialIndex: 0); //öğretmene gelirse, başlangıç olsun
    c.sayfaSecilenIndex.value = 0;
    Get.off(() => LoginYetkiSecSayfa());
  }
  return cevap;
}
