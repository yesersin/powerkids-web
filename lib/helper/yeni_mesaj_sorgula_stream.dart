import '../service/mesaj/mesaj_okunmayan_sayi_getir.dart';
import '../static/cogretmen.dart';
import '../static/cprogram.dart';
import '../static/yetki.dart';

bool mesajDinlemeDevam = true;

Stream<int> yeniMesajSorgula() async* {
  while (mesajDinlemeDevam) {
    await Future.delayed(const Duration(seconds: 3)); //geçici: 9sn olacak
    if (mesajDinlemeDevam == false) break;
    mesajOkunmayanSayiGetir(
            gid: cp.kullanici.data.id, yetki: yetkiText, token: cp.kullanici.token)
        .then((value) {
      // debugPrint("yeniMesajSorgula gelen sayı:" + value!.data!.first!.okunmayan.toString());
      if (value != null) {
        co.mesajOkunmayanSayi.value = value.data!.first?.okunmayan ?? 0;
      }
    });
    // debugPrint("gelen mesaj soruluyor");
  }
}
