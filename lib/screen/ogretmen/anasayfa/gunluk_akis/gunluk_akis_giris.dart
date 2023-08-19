import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/component/gunluk_akis/akis_liste.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/web_api/gunluk_akis.dart';
import '../../../../plugin/lib/calendar_agenda.dart';
import '../../../../service/gunluk_akis/gunluk_akis_getir.dart';
import '../../../../static/hata_mesaj.dart';

class OgretmenGunlukAkisGiris extends StatefulWidget {
  COgretmen c;

  OgretmenGunlukAkisGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenGunlukAkisGiris> createState() => _OgretmenGunlukAkisGirisState();
}

class _OgretmenGunlukAkisGirisState extends State<OgretmenGunlukAkisGiris> {
  // var getAkisService=gunlukAkisGetir(
  // token: cp.kullanici.token,
  // okulId: cp.okul!.data.id,
  // sinifId: cp.sinif.id,
  // tarih: DateTime.now(),
  // yetki: yetkiText,
  // ).obs;
  late Rx<Future<ModelGunlukAkis?>> getAkisService;

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
              calendarLogo: SizedBox(width: 0, height: 0),
              leading: SizedBox(width: 0, height: 0),
              appbar: false,
              backgroundColor: Renk.turuncu,
              selectedDayPosition: SelectedDayPosition.center,
              fullCalendar: false,
              locale: "tr",
              leftMargin: 0,
              padding: 0,
              onDateSelected: (date) async {
                widget.c.secilenTarih.value = date;
                getAkisService.value = gunlukAkisGetir(
                  token: cp.kullanici.token,
                  okulId: cp.okul!.data.id,
                  sinifId: cp.sinif.id,
                  tarih: date,
                  yetki: yetkiText,
                );
              },
            ),
            Obx(
              () => FutureBuilder(
                future: getAkisService.value,
                builder: (BuildContext context, AsyncSnapshot<ModelGunlukAkis?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelGunlukAkis? sonuc = snapshot.data;
                    if (sonuc == null) {
                      // debugPrint("3");

                      Future.delayed(Duration(milliseconds: 50), () {
                        widget.c.akis.clear();
                      });
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      // debugPrint("4");
                      Future.delayed(Duration(milliseconds: 50), () {
                        widget.c.akis.value = sonuc.data;
                      });
                      // toast(msg: "Kayıtlar getirildi.");
                    }
                    return akisListWidget(c: widget.c);
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
    // Future.delayed(Duration(milliseconds: 50), () {
    getAkisService = gunlukAkisGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      tarih: DateTime.now(),
      yetki: yetkiText,
    ).obs;
    // });
  }
}
