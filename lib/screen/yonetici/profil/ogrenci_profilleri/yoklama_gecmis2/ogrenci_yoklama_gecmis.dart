import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_karti.dart';
import 'package:com.powerkidsx/screen/yonetici/profil/ogrenci_profilleri/yoklama_gecmis2/widget/ogrenci_yoklama_gecmis_listesi.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_yoklama_gecmis.dart';
import '../../../../../plugin/lib/calendar_agenda.dart';
import '../../../../../service/ogrenci/ogrenci_yoklama_gecmis_getir.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

class OgretmenOgrenciYoklamaGecmis extends StatefulWidget {
  ModelOgrenciKarti kart;

  OgretmenOgrenciYoklamaGecmis({Key? key, required this.kart}) : super(key: key);

  @override
  State<OgretmenOgrenciYoklamaGecmis> createState() => _OgretmenOgrenciYoklamaGecmisState();
}

class _OgretmenOgrenciYoklamaGecmisState extends State<OgretmenOgrenciYoklamaGecmis> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Container(
      decoration: BoxDecoration(
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
                co.profilOgrenciYoklamaServis.value = ogrenciYoklamaGecmisiGetir(
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
                future: co.profilOgrenciYoklamaServis.value,
                builder: (BuildContext context,
                    AsyncSnapshot<ModelOgrenciYoklamaGecmis?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelOgrenciYoklamaGecmis? sonuc = snapshot.data;
                    if (sonuc == null) {
                      // debugPrint("3");

                      toast(msg: hataMesaj);
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      co.profilOgrenciYoklamaGecmisList.value = sonuc.data;
                      return ogrenciYoklamaGecmisListWidget();
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
    // Future.delayed(Duration(milliseconds: 10),(){
    co.profilOgrenciYoklamaServis = ogrenciYoklamaGecmisiGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      dil: cp.dil,
      ogrenciId: widget.kart.data.ogrenciId,
      tarih: DateTime.now(),
    ).obs;
    // });
  }
}
