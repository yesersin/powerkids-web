import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../../../../model/web_api/ogrenci/ogrenci_karti.dart';

class OgrenciAileKarti extends StatefulWidget {
  COgretmen c;
  ModelOgrenciKarti kart;

  OgrenciAileKarti({Key? key, required this.c, required this.kart}) : super(key: key);

  @override
  State<OgrenciAileKarti> createState() => _OgrenciAileKartiState();
}

class _OgrenciAileKartiState extends State<OgrenciAileKarti> {
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 0, height: 10),
            ozelNot(context),
            SizedBox(width: 0, height: 10),
            yemekEgitimi(context),
            SizedBox(width: 0, height: 10),
            alerjikDurumu(context),
            SizedBox(width: 0, height: 10),
            korkulari(context),
            SizedBox(width: 0, height: 10),
            tuvaletEgitimi(context),
            SizedBox(width: 0, height: 10),
            saglikDurumu(context),
            SizedBox(width: 0, height: 10),
            aliskanliklari(context),
            SizedBox(width: 0, height: 50),
          ],
        ),
      ),
    );
  }

  Widget ozelNot(BuildContext context) {
    return beyazCard(
      baslik: "Özel Not",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.ozelNot,
      ),
    );
  }

  Widget yemekEgitimi(BuildContext context) {
    return beyazCard(
      baslik: "Yemek Eğitimi",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.yemekEgitimi,
      ),
    );
  }

  Widget alerjikDurumu(BuildContext context) {
    return beyazCard(
      baslik: "Alerjik Durumu",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.alerjikDurumu,
      ),
    );
  }

  Widget korkulari(BuildContext context) {
    return beyazCard(
      baslik: "Korkuları",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.korkulari,
      ),
    );
  }

  Widget tuvaletEgitimi(BuildContext context) {
    return beyazCard(
      baslik: "Tuvalet Eğitimi",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.tuvaletEgitimi,
      ),
    );
  }

  Widget saglikDurumu(BuildContext context) {
    return beyazCard(
      baslik: "Sağlık Durumu",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.saglikDurumu,
      ),
    );
  }

  Widget aliskanliklari(BuildContext context) {
    return beyazCard(
      baslik: "Alışkanlıkları",
      icerik: beyazCardAltMenu(
        c: widget.c,
        svgImage: "asset/image/profil_kisisel.svg",
        text: widget.kart.data.aileFormu.aliskanliklari,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
