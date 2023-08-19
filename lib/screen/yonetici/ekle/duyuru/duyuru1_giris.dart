import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../component/pencere/uyari_pencere.dart';
import '../../../../const/renk.dart';
import '../../../../helper/tarih.dart';
import '../../../../helper/url_ac.dart';
import '../../../../model/web_api/duyuru/duyuru_gelen.dart';
import '../../../../model/web_api/ogrenci/ogrenci_get_anything.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/hata_mesaj.dart';
import '../../../ogretmen/anasayfa/duyuru/widget/duyuru_sil_btn.dart';

class YoneticiDuyuruEkleGiris extends StatefulWidget {
  const YoneticiDuyuruEkleGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiDuyuruEkleGiris> createState() => _YoneticiDuyuruEkleGirisState();
}

List<OgrenciAnythingData> _ogrenciList = [];
var duyuruGetir;

class _YoneticiDuyuruEkleGirisState extends State<YoneticiDuyuruEkleGiris> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => body());
  }

  Widget body() {
    if (co.yoneticiDuyuruGuncelle.value == false) {
      return duyuruList();
    }
    return FutureBuilder(
      future: duyuruGetir,
      builder: (BuildContext context, AsyncSnapshot<ModelDuyuruGelen?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        ModelDuyuruGelen? duyuru = snapshot.data;
        if (duyuru == null) {
          // debugPrint("3");
          Future.delayed(Duration.zero, () {
            co.akis.clear();
          });
          // toast(msg: hataMesaj);
          return Center(child: Text(hataMesaj));
        } else {
          // debugPrint("4");
          Future.delayed(Duration.zero, () {
            co.duyuruList.value = duyuru.data;
          });
        }
        return duyuruList();
      },
    );
  }

  Widget duyuruList() {
    return Obx(
      () => ListView.builder(
          itemCount: co.duyuruList.length,
          itemBuilder: (context, index) {
            if (co.duyuruList[index].durum == false) return SizedBox(width: 0, height: 0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: Get.width,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned(left: 5, top: 30, height: 200, child: duyuruAciklama(index)),
                      Positioned(left: 5, top: 0, height: 50, child: duyuruBaslik(index)),
                      Positioned(left: 5, top: 180, height: 50, child: duyuruTarih(index)),
                      if (co.duyuruList[index].dosya.isNotEmpty)
                        Positioned(top: 220, left: 5, child: ekDosya(index)),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget ekDosya(int index) {
    return Container(
      padding: EdgeInsets.all(0),
      width: Get.width - 10,
      height: 30,
      decoration: BoxDecoration(
        color: Renk.kirmizi,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          urlAc(url: co.duyuruList[index].dosya.first);
        },
        icon: Text("+Dosya", style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
    );
  }

  // Widget ekDosya(int index) {
  //   return Column(
  //     children: [
  //       Container(
  //           padding: EdgeInsets.all(10),
  //           width: Get.width - 10,
  //           height: 50,
  //           decoration: BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(16)),
  //           child: IconButton(
  //             onPressed: () {
  //               urlAc(url: co.duyuruList[index].dosya.first);
  //             },
  //             icon: Text("Ek Dosya", style: TextStyle(color: Colors.white)),
  //           )),
  //     ],
  //   );
  // }

  Widget duyuruTarih(int index) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 5),
      width: Get.width - 10,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(Tarih().gunAyYil(co.duyuruList[index].createdAt),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              )),
          Text(co.duyuruList[index].ekleyenAd,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget duyuruAciklama(int index) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 8, right: 5),
      width: Get.width - 10,
      height: 200,
      decoration:
          BoxDecoration(color: Renk.yesil, borderRadius: BorderRadius.circular(0 - 16)),
      child: SingleChildScrollView(
        child: Text(
          co.duyuruList[index].aciklama,
          style: const TextStyle(color: Colors.white, height: 1.2),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget duyuruBaslik(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width - 10,
      decoration: BoxDecoration(
        color: Renk.turuncu,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (co.duyuruList[index].pin) SvgPicture.asset("asset/image/pin.svg"),
          Expanded(
            child: Text(
              co.duyuruList[index].baslik,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          duyuruOnayRed(duyuru: co.duyuruList[index]),
          duyuruSilBtn(index: index, duyuru: co.duyuruList[index], c: co),
        ],
      ),
    );
  }

  Widget duyuruOnayRed({required ModelDuyuru duyuru}) {
    return Row(children: [
      IconButton(
          onPressed: () {
            List<Widget> list = [];
            for (int i = 0; i < duyuru.veliOnayDurum.length; i++) {
              list.add(Text(duyuru.veliOnayDurum[i],
                  style: TextStyle(color: Renk.numaraliRenk(i))));
            }
            Pencere().ac(
                content: Column(mainAxisAlignment: MainAxisAlignment.start, children: list),
                context: context,
                baslik: "Onaylayanlar");
          },
          icon: Icon(Icons.check)),
      IconButton(
          onPressed: () {
            List<Widget> list = [];
            for (int i = 0; i < duyuru.veliRedDurum.length; i++) {
              list.add(
                  Text(duyuru.veliRedDurum[i], style: TextStyle(color: Renk.numaraliRenk(i))));
            }
            Pencere().ac(
                content: Column(mainAxisAlignment: MainAxisAlignment.start, children: list),
                context: context,
                baslik: "Reddedenler");
          },
          icon: Icon(Icons.clear)),
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // co.duyuruList.clear();
    // duyuruGetir = getDuyurular(
    //   token: cp.kullanici.token,
    //   okulId: cp.okul!.data.id,
    //   userId: cp.kullanici.data.id,
    //   sinifId: cp.sinif.id,
    // );
  }
}
