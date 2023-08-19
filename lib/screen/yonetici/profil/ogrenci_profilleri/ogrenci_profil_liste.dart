import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../helper/toast.dart';
import '../../../../model/web_api/sinif_ogrencileri.dart';
import '../../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';
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
    //success -1 ise ilk kez gelmiştir
    // if (co.ogrenciList.value != null && co.ogrenciList.value!.success != -1) {
    //   debugPrint("öğrenci listesi var");
    //   return body();
    // }
    return FutureBuilder(
      future: ogrenciGetirServis,
      builder: (BuildContext context, AsyncSnapshot<ModelSinifOgrencileri?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          toast(msg: hataMesaj);
          return Center(child: Text("Bu sınıfta öğrenci yok!", style: TextStyle()));
        }
        co.ogrenciList.value = snapshot.data!;
        return body();
      },
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
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
        widget.c.yoneticiProfilSayfalari.add(sayfa); //profilSayfalari yoneticiProfilSayfalari
        widget.c.yoneticiSayfalar[4] = sayfa; //ogretmenSayfalar yoneticiSayfalar
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
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
    debugPrint("init");
    // widget.c.ogrenciList=ModelSinifOgrencileri(success: -1, data: []).obs;
  }
}
