import 'package:com.powerkidsx/const/ogun_tip.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/yemek/widget/menu_yemek_baslik.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/yemek/widget/menu_yemekler.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../helper/toast.dart';
import '../../../../model/web_api/veli/veli_yemek_not.dart';
import '../../../../model/web_api/yemek_menu_okul.dart';
import '../../../../plugin/lib/calendar_agenda.dart';
import '../../../../service/veli/veli_yemek_not_getir.dart';
import '../../../../service/yemek_menu/yemek_program_okul_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/hata_mesaj.dart';
import 'ogun_ayrinti/widget/yemek_not_ekle_kontrol.dart';

class OgretmenYemekGiris extends StatefulWidget {
  COgretmen c;

  OgretmenYemekGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenYemekGiris> createState() => _OgretmenYemekGirisState();
}

class _OgretmenYemekGirisState extends State<OgretmenYemekGiris> {
  late Rx<Future<ModelYemekMenuOkul?>> yemekMenuGetirServis;

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
      child: Column(
        children: [
          takvim(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: [
              menuLoader(),
              const SizedBox(height: 50),
            ]),
          )),
        ],
      ),
    );
  }

  Widget menuLoader() {
    return Obx(
      () => FutureBuilder(
        future: yemekMenuGetirServis.value,
        builder: (BuildContext context, AsyncSnapshot<ModelYemekMenuOkul?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          }
          if (snapshot.data == null) {
            toast(msg: hataMesaj);
            return Center(child: Text(hataMesaj, style: TextStyle()));
          }
          widget.c.yemekMenuOkul.value = snapshot.data!;
          return menuleriGoster();
        },
      ),
    );
  }

  Widget menuleriGoster() {
    return Column(
        children: widget.c.yemekMenuOkul.value.data.map((e) => menuList(e)).toList());
  }

  TextEditingController yemekNot = TextEditingController();

  Widget menuList(YemekOgun ogun) {
    return Column(
      children: [
        menuYemekBaslik(
            baslik: Ogun.getOgun(ogun.ogun.toString()),
            click: () async {
              ModelVeliYemekNot? cevap = await veliYemekNotGetir(
                  yil: widget.c.yemekSecilenTarih.value.year.toString(),
                  gun: widget.c.yemekSecilenTarih.value.day.toString(),
                  ay: widget.c.yemekSecilenTarih.value.month.toString(),
                  token: cp.kullanici.token,
                  ogrenciId: co.veliSecilenOgrenci.value.data.id,
                  ogun: ogun.ogun.toString());
              yemekNotEkleKontrol(not: cevap, ogun: ogun.ogun.toString());

              // widget.c.anasayfaSayfalari.add(OgunAyrinti(
              //   c: widget.c,
              //   ogun: ogun,
              // ));
              // widget.c.ogretmenSayfalar[0] = OgunAyrinti(
              //   c: widget.c,
              //   ogun: ogun,
              // );
            }),
        Column(children: menuYemekler(ogun)),
      ],
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
        widget.c.yemekSecilenTarih.value = date;
        yemekMenuGetirServis.value = yemekProgramOkulGetir(
            dil: cp.dil,
            token: cp.kullanici.token,
            okulId: cp.okul!.data.id,
            ay: Tarih.ayDate(date),
            gun: Tarih.gunDate(date),
            yil: Tarih.yilDate(date));
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.c.yemekSecilenTarih.value = DateTime.now();
    yemekMenuGetirServis = yemekProgramOkulGetir(
            dil: cp.dil,
            token: cp.kullanici.token,
            okulId: cp.okul!.data.id,
            ay: Tarih.ay(),
            gun: Tarih.gun(),
            yil: Tarih.yil())
        .obs;
  }
}
