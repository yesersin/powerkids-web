import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_karti.dart';
import 'package:com.powerkidsx/screen/veli2/profil/psikolog_rapor/rapor_list.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../service/ogrenci/ogrenci_etkinlik_gecmis_getir.dart';
import '../../../../../static/cprogram.dart';

class VeliOgrenciPsikologRaporGiris extends StatefulWidget {
  ModelOgrenciKarti kart;

  VeliOgrenciPsikologRaporGiris({Key? key, required this.kart}) : super(key: key);

  @override
  State<VeliOgrenciPsikologRaporGiris> createState() => _VeliOgrenciPsikologRaporGirisState();
}

class _VeliOgrenciPsikologRaporGirisState extends State<VeliOgrenciPsikologRaporGiris> {
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
            SizedBox(width: 0, height: 10),
            ogrenciPsikologRaporListWidget(kart: widget.kart),
            SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    co.profilOgrenciEtkinlikAkisServis = ogrenciEtkinlikGecmisiGetir(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      dil: cp.dil,
      ogrenciId: widget.kart.data.ogrenciId,
      tarih: DateTime.now(),
    ).obs;
  }
}
