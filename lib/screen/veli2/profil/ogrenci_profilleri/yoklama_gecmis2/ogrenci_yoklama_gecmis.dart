import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_karti.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/yoklama_gecmis2/widget/ogrenci_yoklama_gecmis_listesi.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../const/renk.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_yoklama_gecmis.dart';
import '../../../../../plugin/lib/calendar_agenda.dart';
import '../../../../../service/ogrenci/ogrenci_yoklama_gecmis_getir.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

class VeliOgrenciYoklamaGecmis extends StatefulWidget {
  ModelOgrenciKarti kart;

  VeliOgrenciYoklamaGecmis({Key? key, required this.kart}) : super(key: key);

  @override
  State<VeliOgrenciYoklamaGecmis> createState() => _VeliOgrenciYoklamaGecmisState();
}

class _VeliOgrenciYoklamaGecmisState extends State<VeliOgrenciYoklamaGecmis> {
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
            takvim(),
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

                      // toast(msg: hataMesaj);
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

  Widget takvim() {
    return CalendarAgenda(
      initialDate: DateTime.now(),
      calendarLogo: SizedBox(width: 0, height: 0),
      leading: SizedBox(width: 0, height: 0),
      appbar: false,
      backgroundColor: Renk.turuncu,
      selectedDayPosition: SelectedDayPosition.center,
      fullCalendar: false,
      locale: "tr",
      leftMargin: 0,
      firstDate: DateTime.now().subtract(Duration(days: 100)),
      padding: 0,
      lastDate: DateTime.now().add(Duration(days: 100)),
      onDateSelected: (date) async {
        co.profilOgrenciYoklamaServis.value = ogrenciYoklamaGecmisiGetir(
          token: cp.kullanici.token,
          okulId: cp.okul!.data.id,
          dil: cp.dil,
          ogrenciId: widget.kart.data.ogrenciId,
          tarih: date,
        );
        co.secilenTarih.value = date;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    co.secilenTarih.value = DateTime.now();
    co.profilOgrenciYoklamaServis = ogrenciYoklamaGecmisiGetir(
            token: cp.kullanici.token,
            okulId: cp.okul!.data.id,
            dil: cp.dil,
            ogrenciId: widget.kart.data.ogrenciId,
            tarih: DateTime.now())
        .obs;
  }
}
