import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_ilac.dart';
import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_karti.dart';
import 'package:com.powerkidsx/screen/veli2/profil/ogrenci_profilleri/ilac_karti/widget/ogrenci_ilac_listesi.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../const/renk.dart';
import '../../../../../plugin/lib/calendar_agenda.dart';
import '../../../../../service/ogrenci/ogrenci_ilac_getir.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

class VeliOgrenciIlacSaglik extends StatefulWidget {
  ModelOgrenciKarti kart;

  VeliOgrenciIlacSaglik({Key? key, required this.kart}) : super(key: key);

  @override
  State<VeliOgrenciIlacSaglik> createState() => _VeliOgrenciIlacSaglikState();
}

class _VeliOgrenciIlacSaglikState extends State<VeliOgrenciIlacSaglik> {
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
                future: co.profilOgrenciIlacServis.value,
                builder: (BuildContext context, AsyncSnapshot<ModelOgrenciIlac?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelOgrenciIlac? ilac = snapshot.data;
                    if (ilac == null) {
                      // debugPrint("3");

                      // toast(msg: hataMesaj);
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      co.profilOgrenciIlacList.value = [ilac.data];
                      return ogrenciIlacListWidget();
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
        co.profilOgrenciIlacServis.value = ogrenciIlacGetir(
          token: cp.kullanici.token,
          sinifId: cp.sinif.id,
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
    co.profilOgrenciIlacServis = ogrenciIlacGetir(
      token: cp.kullanici.token,
      sinifId: cp.sinif.id,
      dil: cp.dil,
      ogrenciId: widget.kart.data.ogrenciId,
      tarih: DateTime.now(),
    ).obs;
  }
}
