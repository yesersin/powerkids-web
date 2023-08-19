import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/model/web_api/ders_program.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/ders_program/widget/ders_program_list.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/ders_program/widget/takvim.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/ders_program/ders_program_getir_okul.dart';

class OgretmenDersProgramGiris extends StatefulWidget {
  COgretmen c;

  OgretmenDersProgramGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenDersProgramGiris> createState() => _OgretmenDersProgramGirisState();
}

class _OgretmenDersProgramGirisState extends State<OgretmenDersProgramGiris> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          dersProgramTakvim(c: widget.c),
          Expanded(
            child: SingleChildScrollView(
              child: programYukle(),
            ),
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget programYukle() {
    return Obx(() => FutureBuilder(
          future: widget.c.dersProgramServis.value,
          builder: (BuildContext context, AsyncSnapshot<ModelDersProgram?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.data == null) {
              return Text(hataMesaj, style: TextStyle());
              toast(msg: hataMesaj);
            }
            return dersProgramList(program: snapshot.data!, c: widget.c);
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (Random().nextBool()) {
    //   cp.okulAyarlar.data.dersProgrami = "haftalik"; //geçici
    //   cp.kullanici.data.yetki.brans = true; //geçici
    // } else {
    //   cp.okulAyarlar.data.dersProgrami = "aylik"; //geçici
    //   cp.kullanici.data.yetki.brans = false; //geçici
    // }
    if (cp.okulAyarlar.data.dersProgrami == "haftalik") {
      widget.c.dersProgramServis.value = dersProgramOkulGetir(
        token: cp.kullanici.token,
        ay: Tarih.ay(),
        gun: widget.c.dersProgramSecilenTarih.value.day.toString(),
        yil: Tarih.yil(),
        okulId: cp.okul!.data.id,
        tip: cp.okulAyarlar.data.dersProgrami,
        sinifId: cp.sinif.id,
        donem: cp.okulAyarlar.data.donem,
        ogretmenId: cp.kullanici.data.id,
        brans: cp.kullanici.data.yetki.brans,
      );
    } else {
      widget.c.dersProgramServis.value = dersProgramOkulGetir(
        token: cp.kullanici.token,
        ay: widget.c.yemekSecilenTarih.value.month.toString(),
        gun: widget.c.yemekSecilenTarih.value.day.toString(),
        yil: widget.c.yemekSecilenTarih.value.year.toString(),
        okulId: cp.okul!.data.id,
        tip: cp.okulAyarlar.data.dersProgrami,
        sinifId: cp.sinif.id,
        donem: cp.okulAyarlar.data.donem,
        ogretmenId: cp.kullanici.data.id,
        brans: cp.kullanici.data.yetki.brans,
      );
    }
  }
}
