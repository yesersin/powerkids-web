import 'package:com.powerkidsx/const/shared_pref_keys.dart';
import 'package:com.powerkidsx/const/web_api/service_adres.dart';
import 'package:com.powerkidsx/helper/oturumu_kapat.dart';
import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/main.dart';
import 'package:com.powerkidsx/model/web_api/bildirim/bildirim.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_ayarlar.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_durum.dart';
import 'package:com.powerkidsx/service/bildirim/bildirim_getir.dart';
import 'package:com.powerkidsx/service/kullanici/kullanici_giris.dart';
import 'package:com.powerkidsx/service/okul/okul_ayarlar_getir.dart';
import 'package:com.powerkidsx/service/okul/okul_getir.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../component/pencere/okul_sec.dart';
import '../../helper/bildirim/get_notification_id.dart';
import '../../helper/web_api/patch.dart';
import '../../model/web_api/kullanici/kullanici_giris.dart';
import '../../model/web_api/okul/okul_siniflari.dart';
import '../../screen/ogretmen/widget/sinif_sec_btn.dart';
import '../../service/okul/okul_durum_getir.dart';
import '../../service/sinif/siniflari_getir.dart';

Future<bool> checkUserLocal() async {
  String telefon = await Shared().get(key: SharedKeys().telefon);
  String sifre = await Shared().get(key: SharedKeys().sifre);
  // telefon = "5435444018";
  // sifre = "6ac1e56bc78f031059be7be854522c4c";
  if (telefon == "" || sifre == "") return false; //local boş logine git
  return checkUserOnline(sifre: sifre, telefon: telefon);
}

Future<bool> checkUserOnline({required String telefon, required String sifre}) async {
  debugPrint("giriş1");
  ModelKullanici? kullanici = await kullaniciGiris(telefon: telefon, sifre: sifre);
  debugPrint("giriş2");
  if (kullanici == null) {
    return false;
  } else {
    cp.kullanici = kullanici;
  }

  //notification id güncelle
  String notificationId = await getNotificationId();
  patchData(adres: ServiceAdres().kullaniciUpdate, body: {
    "_id": cp.kullanici.data.id,
    "notificationId": notificationId,
  }, headers: {
    "x-access-token": cp.kullanici.token
  });

  //notification id güncelle

  //kullanıcı okulları ekle
  for (var element in cp.kullanici.data.okulId) {
    try {
      ModelOkulDurum? okulDurum =
          await getOkulDurum(okulId: element, token: cp.kullanici.token);
      if (okulDurum == null || okulDurum.data.durum == false) {
        //okul yok ya da durum=false
        continue;
      }

      ModelOkul? okul = await getOkul(okulId: element, token: cp.kullanici.token);
      if (okul != null && okul.data.durum) {
        cp.okulList.add(okul);
        ModelOkulAyarlar? ayar =
            await getOkulAyarlar(okulId: okul.data.id, token: cp.kullanici.token);
        if (ayar == null) {
          debugPrint("ModelOkulAyarlar: - " + ayar.toString());
          toast(msg: "${okul.data.okulAdi} ayarlarında sorun var!");
          cp.okulList.removeLast();
        } else {
          cp.okulAyarlarList.add(ayar);
        }
      }
    } catch (e) {
      debugPrint("Okul modelinde sorun oluştu! okulId:$element  hata:$e");
      // return false;
    }
  }
  if (cp.okulList.isEmpty) {
    toast(msg: "okulbulunamadi".tr);
    await oturumuKapat();
    return false;
  } else {
    //ÖNEMLİ
    //birden fazla okul olabilir. okul seçim ekranı gelecek

    if (cp.okulList.length == 1) {
      cp.okul = cp.okulList.first;
      cp.okulAyarlar = cp.okulAyarlarList.first;
    } else {
      while (cp.okul == null) {
        cp.okul =
            await okulSec(okulList: cp.okulList, context: Get.context!, baslik: "okulsec".tr);
      }
      int okulIndex = cp.okulList.indexWhere((element) => element.data.id == cp.okul!.data.id);
      if (okulIndex != -1) {
        debugPrint("okul index:" + okulIndex.toString());
        cp.okulAyarlar = cp.okulAyarlarList[okulIndex];
      } else {
        toast(msg: "okulsorunvar".tr);
        Get.offAll(() => Main());
      }
    }

    //sinif seç
    ModelOkulSiniflari? siniflar = await getSiniflar(
        okulId: cp.okul!.data.id, token: cp.kullanici.token, donem: cp.okul!.data.aktifDonem);

    if (siniflar == null) {
      toast(msg: "sinifbulunmadi".tr);
      oturumuKapat();
    } else {
      cp.siniflar = siniflar;
      if (cp.kullanici.data.yetki.veli && cp.kullanici.data.ogrenciId.isEmpty) {
        // if (cp.kullanici.data.yetki.ogretmen || cp.kullanici.data.yetki.brans || cp.kullanici.data.yetki.admin) {
        // } else {
        //if (cp.kullanici.data.ogrenciId.isEmpty) {
        debugPrint("Veliye öğrenci eşleştirmesi yapılmamış!");
        toast(msg: "Veliye öğrenci eşleştirmesi yapılmamış!");
        yveli = false;
        // }
        //}
      }
      if (ogretmenSiniflari().isEmpty) {
        if ((!cp.kullanici.data.yetki.admin &&
            (cp.kullanici.data.yetki.ogretmen || cp.kullanici.data.yetki.brans))) {
          //öğretmenin sınıfId sinde bulunan sınıflar yoksa çıkış yaptırıyor.
          debugPrint("Öğretmene tanımlanmış sınıf bulunamadı!");
          toast(msg: "Öğretmene tanımlanmış sınıf bulunamadı!");
          // await oturumuKapat();
          // return false;
          yogretmen = false;
        }
      }
      //sınıf seçiliyor:kullanıcı sınıfId listesindeki sınıf ıdler
      //okul sınıfları içinde aranıyor. ilk bulunan sınıf alınıp program devam ediyor.
      //eğer kullanıcının sınıfları okul sınıf listesinde yoksa oturum kapatılıyor.
      int index = -1;
      if (cp.kullanici.data.yetki.admin ||
          cp.kullanici.data.yetki.ogretmen ||
          cp.kullanici.data.yetki.brans) {
        for (int i = 0; i < cp.kullanici.data.sinifId.length; i++) {
          if (cp.siniflar.data.any((e) => e.id == cp.kullanici.data.sinifId[i])) {
            index = cp.siniflar.data.indexWhere((e) => e.id == cp.kullanici.data.sinifId[i]);
            break;
          }
        }
      }
      if (cp.kullanici.data.yetki.admin) {
        cp.sinif = cp.siniflar.data.first;
      }
      if (cp.kullanici.data.yetki.admin == false &&
          (cp.kullanici.data.yetki.ogretmen == true ||
              cp.kullanici.data.yetki.brans == true) &&
          index == -1) {
        debugPrint("Kullanıcının sınıfları okul sınıf listesinde bulunamadı!");
        toast(msg: "Kullanıcının sınıfları okul sınıf listesinde bulunamadı!");
        oturumuKapat();
        return false;
      } else if (cp.kullanici.data.yetki.admin == false &&
          cp.kullanici.data.yetki.veli == false) {
        cp.sinif = cp.siniflar.data[index];
      }
      // cp.sinif = cp.siniflar.data.first;
    }

    //bildirim getir
    ModelBildirim? b = await getBildirim(
        okulId: cp.okul!.data.id, alanId: cp.kullanici.data.id, token: cp.kullanici.token);
    cp.bildirimler = b; //bildirim yoksa null, varsa modelbildirim atanır
    //bildirim getir

    return true;
  }
}
