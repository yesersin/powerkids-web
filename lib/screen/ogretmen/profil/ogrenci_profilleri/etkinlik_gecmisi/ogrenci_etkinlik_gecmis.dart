import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_karti.dart';
import 'package:com.powerkidsx/screen/ogretmen/profil/ogrenci_profilleri/etkinlik_gecmisi/widget/ogrenci_etkinlik_gecmis_listesi.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../const/renk.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_etklnlik_gecmis.dart';
import '../../../../../plugin/lib/calendar_agenda.dart';
import '../../../../../service/ogrenci/ogrenci_etkinlik_gecmis_getir.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

class OgretmenOgrenciEtkinlikGecmis extends StatefulWidget {
  ModelOgrenciKarti kart;

  OgretmenOgrenciEtkinlikGecmis({Key? key, required this.kart}) : super(key: key);

  @override
  State<OgretmenOgrenciEtkinlikGecmis> createState() => _OgretmenOgrenciEtkinlikGecmisState();
}

class _OgretmenOgrenciEtkinlikGecmisState extends State<OgretmenOgrenciEtkinlikGecmis> {
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
                co.secilenTarih.value = date;
                co.profilOgrenciEtkinlikAkisServis.value = ogrenciEtkinlikGecmisiGetir(
                  token: cp.kullanici.token,
                  okulId: cp.okul!.data.id,
                  dil: cp.dil,
                  ogrenciId: widget.kart.data.ogrenciId,
                  tarih: date,
                );
              },
            ),
            SizedBox(width: 0, height: 10),
            Obx(
              () => FutureBuilder(
                future: co.profilOgrenciEtkinlikAkisServis.value,
                builder: (BuildContext context,
                    AsyncSnapshot<ModelOgrenciEtkinlikGecmis?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelOgrenciEtkinlikGecmis? sonuc = snapshot.data;
                    if (sonuc == null) {
                      // debugPrint("3");
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      co.profilOgrenciGecmisEtkinlikList.value = sonuc.data;
                      return ogrenciEtkinlikGecmisListWidget();
                    }
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
    // Future.delayed(Duration(milliseconds: 1), () {
    co.profilOgrenciEtkinlikAkisServis = ogrenciEtkinlikGecmisiGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      dil: cp.dil,
      ogrenciId: widget.kart.data.ogrenciId,
      tarih: DateTime.now(),
    ).obs;
    // });
  }
}
