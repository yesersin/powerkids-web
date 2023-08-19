import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';
import '../../../../../plugin/lib/calendar_agenda.dart';
import '../../../../../service/ders_program/ders_program_getir_okul.dart';
import '../../../../../static/cprogram.dart';

List<String> _gunler = ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma"];

Widget dersProgramTakvim({required COgretmen c}) {
  if (cp.okulAyarlar.data.dersProgrami == "haftalik") {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Renk.turuncu,
        width: Get.width,
        child: GroupButton(
          controller: c.haftalikBtnController,
          buttons: _gunler,
          onSelected: (text, index, value) {
            // widget.c.dersProgramSecilenTarih.value = date;
            c.dersProgramServis.value = dersProgramOkulGetir(
              token: cp.kullanici.token,
              ay: Tarih.ay(),
              gun: c.dersProgramSecilenTarih.value.day.toString(),
              yil: Tarih.yil(),
              okulId: cp.okul!.data.id,
              tip: cp.okulAyarlar.data.dersProgrami,
              sinifId: cp.sinif.id,
              donem: cp.okulAyarlar.data.donem,
              ogretmenId: cp.kullanici.data.id,
              brans: cp.kullanici.data.yetki.brans,
            );
          },
          options: GroupButtonOptions(
            runSpacing: 0,
            spacing: 0,
            groupingType: GroupingType.row,
            unselectedColor: Renk.turuncu,
            unselectedTextStyle: TextStyle(color: Colors.white, fontSize: 12),
            selectedColor: Colors.white,
            selectedTextStyle: TextStyle(color: Colors.black, fontSize: 12),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  return CalendarAgenda(
    initialDate: DateTime.now(),
    firstDate: DateTime.utc(int.parse(Tarih.yil()), int.parse(Tarih.ay()), 1),
    lastDate:
        DateTime.utc(int.parse(Tarih.yil()), int.parse(Tarih.ay()), 1).add(Duration(days: 31)),
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
      c.dersProgramSecilenTarih.value = date;
      c.dersProgramServis.value = dersProgramOkulGetir(
        token: cp.kullanici.token,
        ay: c.dersProgramSecilenTarih.value.month.toString(),
        gun: c.dersProgramSecilenTarih.value.day.toString(),
        yil: c.dersProgramSecilenTarih.value.year.toString(),
        okulId: cp.okul!.data.id,
        tip: cp.okulAyarlar.data.dersProgrami,
        sinifId: cp.sinif.id,
        donem: cp.okulAyarlar.data.donem,
        ogretmenId: cp.kullanici.data.id,
        brans: cp.kullanici.data.yetki.brans,
      );
    },
  );
}
