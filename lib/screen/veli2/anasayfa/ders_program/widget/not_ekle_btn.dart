import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/button.dart';
import '../../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/ders_program.dart';
import '../../../../../model/web_api/ogretmen_ders_not_update_cevap.dart';
import '../../../../../service/ogretmen_ders_not/ogretmen_ders_not_add.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget notEkleBtn({required DersProgram ders, required COgretmen c}) {
  return Buton().mavi(
      click: () async {
        if (c.notText.text.length <= 3) {
          toast(msg: "Lütfen en az 5 karakter not yazınız.");
          return;
        }
        Get.context!.loaderOverlay.show();
        ModelOgretmenDersNotUpdateCevap? sonuc = await addOgretmenDersNot(
          gun: c.dersProgramSecilenTarih.value.day.toString(),
          ay: c.dersProgramSecilenTarih.value.month.toString(),
          yil: c.dersProgramSecilenTarih.value.year.toString(),
          notText: c.notText.text,
          dil: cp.dil,
          baslik: c.secilenNotBaslik.value,
          ders: ders.baslik,
          dersId: ders.id,
          ogretmenAdSoyad: cp.kullanici.data.adSoyad,
          ogretmenId: cp.kullanici.data.id,
          okulId: cp.okul!.data.id,
          sinifId: cp.sinif.id,
          file: c.dersProgramNotEkleSecilenDosyalar.isNotEmpty
              ? c.dersProgramNotEkleSecilenDosyalar.first
              : null,
          token: cp.kullanici.token,
        );
        if (sonuc == null) {
          Get.context!.loaderOverlay.hide();
          toast(msg: hataMesaj);
          return;
        } else {
          listeBildirimGonder(tip: "2", body: "Veli not ekledi", pushBildirim: true);
          toast(msg: "Not eklendi.");
          Get.context!.loaderOverlay.hide();
          Get.back();
        }
      },
      text: "Ekle");
}
