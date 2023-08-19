import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/model/veli_gunluk_akis.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/gunluk_akis/widget/akis_liste.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../plugin/lib/calendar_agenda.dart';
import '../../../../service/veli/veli_gunluk_akis_getir.dart';
import '../../../../static/cogretmen.dart';

class VeliGunlukAkisGiris extends StatefulWidget {
  VeliGunlukAkisGiris({Key? key}) : super(key: key);

  @override
  State<VeliGunlukAkisGiris> createState() => _VeliGunlukAkisGirisState();
}

class _VeliGunlukAkisGirisState extends State<VeliGunlukAkisGiris> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CalendarAgenda(
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 15)),
              lastDate: DateTime.now(),
              calendarLogo: const SizedBox(width: 0, height: 0),
              leading: const SizedBox(width: 0, height: 0),
              appbar: false,
              backgroundColor: Renk.turuncu,
              selectedDayPosition: SelectedDayPosition.center,
              fullCalendar: false,
              locale: "tr",
              leftMargin: 0,
              padding: 0,
              onDateSelected: (date) async {
                co.secilenTarih.value = date;
                co.veliGetAkisService.value = veliGunlukAkisGetir(
                  ogrenciId: co.veliSecilenOgrenci.value.data.id,
                  dil: cp.dil,
                  token: cp.kullanici.token,
                  okulId: cp.okul!.data.id,
                  sinifId: cp.sinif.id,
                  tarih: date,
                  yetki: yetkiText,
                );
              },
            ),
            const SizedBox(width: 0, height: 10),
            Obx(
              () => FutureBuilder(
                future: co.veliGetAkisService.value,
                builder:
                    (BuildContext context, AsyncSnapshot<List<ModelVeliGunlukAkis>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    List<ModelVeliGunlukAkis> sonuc = snapshot.data!;
                    if (sonuc.isEmpty) {
                      // debugPrint("3");

                      // toast(msg: "Akış bulunamadı.");
                      return const Text("Akış bulunamadı.", style: TextStyle());
                    } else {
                      // debugPrint("4");
                      co.veliAkisList.value = sonuc;
                      // toast(msg: "Kayıtlar getirildi.");
                    }
                    return veliAkisListWidget(c: co);
                  }
                  return const Text("Hatalı kayıt!", style: TextStyle());
                },
              ),
            ),
            const SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    debugPrint("veli öğrenciid:" + co.veliSecilenOgrenci.value.data.id);
    co.veliAkisList.value.clear();
    co.veliGetAkisService = veliGunlukAkisGetir(
      ogrenciId: co.veliSecilenOgrenci.value.data.id,
      dil: cp.dil,
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      tarih: DateTime.now(),
      yetki: yetkiText,
    ).obs;
  }
}
