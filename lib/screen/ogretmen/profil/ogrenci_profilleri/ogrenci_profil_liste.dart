import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../model/web_api/sinif_ogrencileri.dart';
import '../../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';
import 'profil_sayfasi/ogrenci_profil_ayrinti.dart';

class OgrenciProfilleriListele extends StatefulWidget {
  COgretmen c;

  OgrenciProfilleriListele({Key? key, required this.c}) : super(key: key);

  @override
  State<OgrenciProfilleriListele> createState() => _OgrenciProfilleriListeleState();
}

class _OgrenciProfilleriListeleState extends State<OgrenciProfilleriListele> {
  var ogrenciGetirServis;

  @override
  Widget build(BuildContext context) {
    return ogrenciKontrol();
  }

  Widget ogrenciKontrol() {
    return FutureBuilder(
      future: ogrenciGetirServis,
      builder: (BuildContext context, AsyncSnapshot<ModelSinifOgrencileri?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        } else {
          if (snapshot.data == null) {
            return Center(child: Text("Bu sınıfta öğrenci yok!", style: TextStyle()));
          }
          // Future.delayed(Duration.zero,(){
          co.ogrenciList.value = snapshot.data!;
          // co.ogrenciList.refresh();
          // });
          return body();
        }
      },
    );
  }

  Widget body() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(children: ogrenciProfilListesi()),
      ),
    );
  }

  List<Widget> ogrenciProfilListesi() {
    debugPrint("kullanıcı id:" + cp.kullanici.data.id);
    List<Widget> list = [];
    for (int i = 0; i < co.ogrenciList.value!.data.length; i++) {
      debugPrint("öğrenci id:" + co.ogrenciList.value!.data[i].id);
      list.add(
        ogrenciProfilCard(
            ogrenci: co.ogrenciList.value!.data[i],
            index: i,
            sayfa: OgretmenOgrenciProfilAyrinti(
              c: widget.c,
              rxSayfa: co.ogretmenSayfalar,
              index: 4,
              sayfa: co.profilSayfalari,
            ),
            komut: () {
              widget.c.profilSecilenOgrenci.value = co.ogrenciList.value!.data[i];
            }),
      );
    }
    return list;
  }

  Widget ogrenciProfilCard(
      {required ModelOgrenci ogrenci,
      required int index,
      required Widget sayfa,
      Function? komut}) {
    return InkWell(
      onTap: () {
        print("1");
        if (komut != null) {
          komut();
          debugPrint("komut çalıştı");
        }
        widget.c.profilSayfalari.add(sayfa);
        widget.c.ogretmenSayfalar[4] = sayfa;
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            color: Renk.numaraliRenk(index), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: ogrenci.fotografUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            child: Text(
              ogrenci.adSoyad,
              style: TextStyle(color: Renk.beyazMetin, fontSize: 22),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Renk.beyazMetin,
            ),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Renk.numaraliRenk(index),
              size: 40,
            ),
          ),
          SizedBox(width: 4, height: 0),
        ]),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(milliseconds: 0),(){
    //   ogrenciGetirServis = getSinifOgrencileri(
    //       token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
    // });
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
    // widget.c.ogrenciList=ModelSinifOgrencileri(success: -1, data: []).obs;
  }
}
