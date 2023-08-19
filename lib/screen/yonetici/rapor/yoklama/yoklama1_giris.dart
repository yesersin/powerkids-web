import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/model/web_api/yoklama/yoklama.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/card/yoklamaCard.dart';
import '../../../../const/radius.dart';
import '../../../../const/yoklama_tip.dart';
import '../../../../helper/tarih.dart';
import '../../../../model/yoklama_btn.dart';
import '../../../../plugin/lib/calendar_agenda.dart';
import '../../../../service/yoklama/yoklama_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/hata_mesaj.dart';

class YoneticiRaporYoklamaGiris extends StatefulWidget {
  YoneticiRaporYoklamaGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiRaporYoklamaGiris> createState() => _YoneticiRaporYoklamaGirisState();
}

List<ModelYoklamaBtn> yoklamaBtnList = [
  ModelYoklamaBtn(text: "Sabah Yoklama", tip: YoklamaTip.okula_geldi),
  ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim),
  ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti),
  ModelYoklamaBtn(text: "Teslim Yoklama", tip: YoklamaTip.teslim_edildi)
];

class _YoneticiRaporYoklamaGirisState extends State<YoneticiRaporYoklamaGiris> {
  @override
  Widget build(BuildContext context) {
    return body();
  }

  String tip = "1";

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
                co.getYoneticiYoklamaAkisService.value = yoklamaGetir(
                    token: cp.kullanici.token,
                    okulId: cp.okul!.data.id,
                    sinifId: cp.sinif.id,
                    dil: cp.dil,
                    tip: co.yoklamaSecilen.value.tip,
                    ay: co.secilenTarih.value.month.toString(),
                    gun: co.secilenTarih.value.day.toString(),
                    yil: co.secilenTarih.value.year.toString());
              },
            ),
            SizedBox(width: 0, height: 10),
            Obx(() => yoklamaDropBtn()),
            SizedBox(width: 0, height: 10),
            Obx(
              () => FutureBuilder(
                future: co.getYoneticiYoklamaAkisService.value,
                builder: (BuildContext context, AsyncSnapshot<ModelYoklama?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // debugPrint("1");
                    return yukleniyor();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // debugPrint("2");
                    ModelYoklama? sonuc = snapshot.data;
                    if (sonuc == null) {
                      // debugPrint("3");
                      co.yoneticiYoklamaAkis.clear();
                      // toast(msg: hataMesaj);
                      return Text(hataMesaj, style: TextStyle());
                    } else {
                      // debugPrint("4");
                      co.yoneticiYoklamaAkis.value = sonuc.data;
                      // toast(msg: "Kayıtlar getirildi.");
                    }
                    return yoklamaListWidget();
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

  Widget yoklamaListWidget() {
    return Obx(
      () => ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: co.yoneticiYoklamaAkis.length,
          itemBuilder: (context, index) {
            return yoklamaCard(
              saat: Tarih().saatDk(co.yoneticiYoklamaAkis[index].zaman),
              mesaj: co.yoneticiYoklamaAkis[index].ogrenciId.adSoyad,
              yoklamaDurum: co.yoneticiYoklamaAkis[index].yoklamaDurum,
              renk: Renk.numaraliRenk(index),
            );
          }),
    );
  }

  Widget yoklamaDropBtn() {
    return DropdownButton2<ModelYoklamaBtn>(
      dropdownMaxHeight: 200,
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.white,
      ),
      isExpanded: true,
      buttonPadding: EdgeInsets.only(left: 10, right: 5),
      buttonDecoration: BoxDecoration(
          color: Renk.maviAcik,
          borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(3, 3),
            )
          ]),
      dropdownDecoration: BoxDecoration(
          color: Renk.maviAcik,
          borderRadius: BorderRadius.circular(RadiusSabit.dropdownRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(3, 3),
            )
          ]),
      items: yoklamaBtnList
          .map((item) => DropdownMenuItem<ModelYoklamaBtn>(
                value: item,
                child: Text(
                  item.text,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: co.yoklamaSecilen.value,
      onChanged: (value) async {
        co.yoklamaSecilen.value = value!;
        co.getYoneticiYoklamaAkisService.value = yoklamaGetir(
            token: cp.kullanici.token,
            okulId: cp.okul!.data.id,
            sinifId: cp.sinif.id,
            dil: cp.dil,
            tip: co.yoklamaSecilen.value.tip,
            ay: co.secilenTarih.value.month.toString(),
            gun: co.secilenTarih.value.day.toString(),
            yil: co.secilenTarih.value.year.toString());
      },
      buttonHeight: 40,
      // buttonWidth: Get.width * 0.4,
      itemHeight: 40,
    );
  }

  @override
  void initState() {
    super.initState();
    co.getYoneticiYoklamaAkisService = yoklamaGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      tip: tip,
      ay: Tarih.ay(),
      gun: Tarih.gun(),
      yil: Tarih.yil(),
      dil: cp.dil,
    ).obs;
    co.yoklamaSecilen.value = yoklamaBtnList.first;
    // Future.delayed(const Duration(milliseconds: 10), () {
    //   // yoklamaBtnList.clear();
    //   // yoklamaBtnList
    //   //     .add(ModelYoklamaBtn(text: "Sabah Yoklama", tip: YoklamaTip.okula_geldi));
    //   // yoklamaBtnList
    //   //     .add(ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim));
    //   // yoklamaBtnList.add(ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti));
    //   // yoklamaBtnList
    //   //     .add(ModelYoklamaBtn(text: "Teslim Yoklama", tip: YoklamaTip.teslim_edildi));
    //   co.yoklamaSecilen.value = yoklamaBtnList.first;
    // });
  }
}
