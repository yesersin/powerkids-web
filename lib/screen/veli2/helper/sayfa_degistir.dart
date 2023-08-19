import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/veli2/helper/sayfalari_temizle.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../anasayfa/veli_anasayfa_giris.dart';
import '../profil/veli_ogrenci_profil_giris.dart';

Future<void> veliSayfaDegistir(
    {required int index,
    required COgretmen c,
    required PersistentTabController tabController}) async {
  if (c.bildirimSayfasi.value) {
    veliSayfalariTemizle(c: c);
    c.bildirimSayfasi.value = false;
    return;
  }
  //anasayfada seçilen sayfadan devam etmek için, anasayfaya 2 kere tıklayınca
  //menu gelmesi için
  if (c.sayfaSecilenIndex.value == index && index == 0) {
    c.veliAnasayfaSayfalari = [VeliAnasayfaGiris()];
    c.syfGunlukAkis.value = false;
    c.syfDuyuru.value = false;
    c.syfFotografYukle.value = false;
    c.syfEtkinlikler.value = false;
    c.syfDersProgram.value = false;
    c.syfYemekMenu.value = false;
    c.syfHakkinda.value = false;
    c.veliSayfalar[0] = VeliAnasayfaGiris(); //açılmış sayfaları temizle
  }
  if (c.sayfaSecilenIndex.value == index && index == 2) {
    c.veliIlacSayfaEkleBtn.value = false;
    c.veliProfilSayfalari = [VeliOgrenciProfilGiris()];
    c.veliSayfalar[2] = VeliOgrenciProfilGiris();
  }
  c.sayfaSecilenIndex.value = index;
  c.veliIlacSayfaEkleBtn.value = false;
}
