import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/component/card/beyazCardAltMenu.dart';
import 'package:com.powerkidsx/component/card/beyaz_card.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/screen/ogretmen/profil/ogrenci_profilleri/profil_sayfasi/widget/isim.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../static/cogretmen.dart';
import '../../../../../../static/hata_mesaj.dart';
import '../../../../model/web_api/sinif_ogretmenleri.dart';
import '../../../../service/sinif/sinif_ogretmenleri_getir.dart';

class OgrenciSinifOgretmenleri extends StatefulWidget {
  OgrenciSinifOgretmenleri({Key? key}) : super(key: key);

  @override
  State<OgrenciSinifOgretmenleri> createState() => _OgrenciSinifOgretmenleriState();
}

class _OgrenciSinifOgretmenleriState extends State<OgrenciSinifOgretmenleri> {
  late ModelSinifOgretmenleri ogretmenList;

  @override
  Widget build(BuildContext context) {
    Get.context!.loaderOverlay.hide();
    return FutureBuilder(
      future: sinifOgretmenleriGetir(
        okulId: cp.okul!.data.id,
        sinifId: cp.sinif.id, //geçici
        token: cp.kullanici.token,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelSinifOgretmenleri?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data != null) {
          ogretmenList = snapshot.data!;
          return body();
        } else {
          //hata
          return Center(child: Text(hataMesaj, style: TextStyle()));
        }
      },
    );
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
      child: SingleChildScrollView(
        child: Column(
          children: ogretmenler(),
        ),
      ),
    );
  }

  List<Widget> ogretmenler() {
    List<Widget> list = [];
    for (var element in ogretmenList.data) {
      if (element.gorunme == false) continue;
      list.add(
        Column(children: [
          avatar(url: element.fotografUrl),
          SizedBox(width: 0, height: 5),
          isim(isim: element.adSoyad),
          SizedBox(width: 0, height: 5),
          isim(isim: yetki(data: element.yetki)),
          SizedBox(width: 0, height: 5),
          Card(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              child: Text(element.cv, style: TextStyle()),
            ),
          )
        ]),
      );
    }
    return list;
  }

  Widget veliAdSoyad() {
    return beyazCard(
      baslik: "Veli Ad Soyad",
      icerik: beyazCardAltMenu(
        komut: () {},
        c: co,
        svgImage: "asset/image/profil_kisisel.svg",
        text: co.profilAdSoyad.value,
        svgIcon: "asset/image/edit_duzenle.svg",
      ),
    );
  }

  Widget avatar({required String url}) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: 150,
      height: 150,
      // color: Colors.red,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(url),
              radius: 150,
            ),
          ],
        ),
      ),
    );
  }

  String yetki({required SinifOgretmeniYetki data}) {
    if (data.admin) {
      return "Yönetici";
    } else if (data.brans) {
      return "Branş Öğretmeni";
    } else {
      return "Sınıf Öğretmeni";
    }
  }
}
