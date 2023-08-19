import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/helper/sayfalari_temizle.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../anasayfa/ogretmen_anasayfa_giris.dart';
import '../profil/ogretmen_profil_giris.dart';

Future<void> sayfaDegisimi(
    {required int index,
    required COgretmen c,
    required PersistentTabController tabController}) async {
  //kamera
  // if (index == 2) {
  //   showDialog(
  //       context: Get.context!,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: fotografVideoYukle(c: c),
  //         );
  //       });
  //   tabController.jumpToTab(0);
  //   return;
  //
  //   // bool izin = await Izin().fotovideo(Get.context!);
  //   // if (!izin) {
  //   //   toast(msg: "Kamera erişim izni alınamadı!");
  //   //   print("izin verilmedi");
  //   //   return;
  //   // }
  //   // // print("xx1");
  //   //
  //   // XFile? image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90);
  //   // if (image != null) {
  //   //   //fotoğraf çekildiyse
  //   //   int size = await image.length();
  //   //   c.akisSecilenDosyalar.add(PlatformFile(name: image.name, path: image.path, size: size));
  //   //   c.sayfalar[0] = FotografYukleEkran(c: c);
  //   //   c.syfFotografYukle.value = true;
  //   //   // print("xx4");
  //   //   tabController.jumpToTab(0);
  //   // }
  //   // // print("xx5");
  //   return;
  // }
  // print("xx3");

  if (c.bildirimSayfasi.value) {
    sayfalariTemizle(c: c);
    c.bildirimSayfasi.value = false;
    return;
  }
  //anasayfada seçilen sayfadan devam etmek için, anasayfaya 2 kere tıklayınca
  //menu gelmesi için
  if (c.sayfaSecilenIndex.value == index && index == 0) {
    c.anasayfaSayfalari = [OgretmenAnasayfaGiris()];
    c.syfGunlukAkis.value = false;
    c.syfDuyuru.value = false;
    c.syfFotografYukle.value = false;
    c.syfEtkinlikler.value = false;
    c.syfDersProgram.value = false;
    c.syfYemekMenu.value = false;
    c.syfHakkinda.value = false;
    c.ogretmenSayfalar[0] = OgretmenAnasayfaGiris(); //açılmış sayfaları temizle
  }
  if (c.sayfaSecilenIndex.value == index && index == 4) {
    c.profilSayfalari = [OgretmenProfilGiris()];
    c.ogretmenSayfalar[4] = OgretmenProfilGiris();
  }
  c.sayfaSecilenIndex.value = index;
}
