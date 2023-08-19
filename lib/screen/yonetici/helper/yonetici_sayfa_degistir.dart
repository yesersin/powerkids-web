import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/yonetici/helper/sayfalari_temizle.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../anasayfa/anasayfa_giris.dart';
import '../ekle/ekle_giris.dart';
import '../mesaj/mesaj_giris.dart';
import '../profil/yonetici_profil_giris.dart';
import '../rapor/rapor1_giris.dart';

Future<void> yoneticiSayfaDegisimi(
    {required int index,
    required COgretmen c,
    required PersistentTabController tabController}) async {
  if (c.bildirimSayfasi.value) {
    sayfalariTemizle(c: c);
    c.bildirimSayfasi.value = false;
    return;
  }

  //anasayfada seçilen sayfadan devam etmek için, anasayfaya 2 kere tıklayınca
  //menu gelmesi için
  if (c.sayfaSecilenIndex.value == index && index == 0) {
    c.yoneticiAnasayfaSayfalari = [YoneticiAnasayfaGiris()];
    c.yoneticiSayfalar[0] = YoneticiAnasayfaGiris(); //açılmış sayfaları temizle
  } else if (c.sayfaSecilenIndex.value == index && index == 1) {
    c.yoneticiVeliEkle.value = false;
    c.yoneticiOgretmenEkle.value = false;
    c.yoneticiDuyuruEkle.value = false;
    c.yoneticiEkleSayfalari = [YoneticiEkleGiris()];
    c.yoneticiSayfalar[1] = YoneticiEkleGiris(); //açılmış sayfaları temizle
  } else if (c.sayfaSecilenIndex.value == index && index == 2) {
    c.yoneticiMesajSayfalari = [YoneticiMesajGiris()];
    c.yoneticiSayfalar[2] = YoneticiMesajGiris(); //açılmış sayfaları temizle
  } else if (c.sayfaSecilenIndex.value == index && index == 3) {
    c.yoneticiRaporSayfalari = [YoneticiRaporGiris()];
    c.yoneticiSayfalar[3] = YoneticiRaporGiris(); //açılmış sayfaları temizle
  } else if (c.sayfaSecilenIndex.value == index && index == 4) {
    c.yoneticiProfilSayfalari = [YoneticiProfilGiris()];
    c.yoneticiSayfalar[4] = YoneticiProfilGiris();
  }

  c.sayfaSecilenIndex.value = index;
}
