import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/yonetici/anasayfa/etkinlikler/widget/etkinlik_akis_liste.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/web_api/yonetici_etkinlik_akis.dart';
import '../../../../plugin/lib/calendar_agenda.dart';
import '../../../../service/etkinlik_akis/yonetici_etkinlik_akis_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/hata_mesaj.dart';

class YoneticiRaporEtkinliGiris extends StatefulWidget {
  YoneticiRaporEtkinliGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiRaporEtkinliGiris> createState() => _YoneticiRaporEtkinliGirisState();
}

class _YoneticiRaporEtkinliGirisState extends State<YoneticiRaporEtkinliGiris> {
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
              firstDate: DateTime.now().subtract(Duration(days: 60)),
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
                co.getYoneticiAkisService.value = yoneticiEtkinlikAkisGetir(
                  token: cp.kullanici.token,
                  okulId: cp.okul!.data.id,
                  sinifId: cp.sinif.id,
                  tarih: date,
                );
              },
            ),
            Obx(
              () => FutureBuilder(
                future: co.getYoneticiAkisService.value,
                builder: (BuildContext context,
                    AsyncSnapshot<ModelYoneticiEtkinlikAkis?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelYoneticiEtkinlikAkis? sonuc = snapshot.data;
                    if (sonuc == null) {
                      // debugPrint("3");
                      Future.delayed(Duration(milliseconds: 50), () {
                        co.akis.clear();
                      });

                      // toast(msg: hataMesaj);
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      // debugPrint("4");
                      Future.delayed(Duration(milliseconds: 50), () {
                        co.yoneticiEtkinlikAkis.value = sonuc.data;
                      });
                      // toast(msg: "Kayıtlar getirildi.");
                    }
                    return etkinlikAkisListWidget(c: co);
                  }
                  return Text("Hatalı kayıt!", style: TextStyle());
                },
              ),
            ),
            SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    co.getYoneticiAkisService = yoneticiEtkinlikAkisGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      tarih: DateTime.now(),
    ).obs;
    // Future.delayed(Duration(milliseconds: 50), () {
    //   co.getYoneticiAkisService.value = yoneticiEtkinlikAkisGetir(
    //     token: cp.kullanici.token,
    //     okulId: cp.okul!.data.id,
    //     sinifId: cp.sinif.id,
    //     tarih: DateTime.now(),
    //
    //   );
    // });
  }
}
