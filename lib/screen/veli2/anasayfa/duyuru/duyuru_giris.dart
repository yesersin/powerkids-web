import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_gelen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../const/renk.dart';
import '../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../helper/toast.dart';
import '../../../../service/duyuru/duyuru_getir.dart';
import '../../../../service/duyuru/duyuru_up_veli_onay_durum.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/hata_mesaj.dart';

class OgretmenDuyuruGiris extends StatefulWidget {
  COgretmen c;

  OgretmenDuyuruGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenDuyuruGiris> createState() => _OgretmenDuyuruGirisState();
}

class _OgretmenDuyuruGirisState extends State<OgretmenDuyuruGiris> {
  var duyuruGetir;
  TextEditingController baslikDuzenle = TextEditingController();
  TextEditingController aciklamaDuzenle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return FutureBuilder(
      future: duyuruGetir,
      builder: (BuildContext context, AsyncSnapshot<ModelDuyuruGelen?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        ModelDuyuruGelen? duyuru = snapshot.data;

        if (duyuru == null) {
          // debugPrint("3");
          Future.delayed(Duration(milliseconds: 50), () {
            widget.c.akis.clear();
          });
          toast(msg: hataMesaj);
        } else {
          // debugPrint("4");
          Future.delayed(Duration(milliseconds: 50), () {
            widget.c.duyuruList.value = duyuru.data;
          });

          // widget.c.duyuruList.add(duyuru.data.first);
          // toast(msg: "Kayıtlar getirildi.");
        }

        return duyuruList();
      },
    );
  }

  Widget duyuruList() {
    // cp.kullanici.data.ebeveynMi = false;
    return Obx(
      () => ListView.builder(
          itemCount: widget.c.duyuruList.length,
          itemBuilder: (context, index) {
            if (widget.c.duyuruList[index].durum == false) {
              debugPrint("false");
              return const SizedBox(width: 0, height: 0);
            }
            if (!(widget.c.duyuruList[index].oncelik == 1 ||
                widget.c.duyuruList[index].oncelik == 3)) {
              debugPrint("false2");
              return const SizedBox(width: 0, height: 0);
            }
            if (widget.c.duyuruList[index].ebeveyn && !cp.kullanici.data.ebeveynMi) {
              debugPrint("false3");
              return const SizedBox(width: 0, height: 0);
            }
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
          urlAc(url: widget.c.duyuruList[index].dosya.first);
        },
        icon: Text("+Dosya", style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
    );
  }

  // Container ekDosya(int index) {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     width: Get.width - 50,
  //     height: 50,
  //     decoration:
  //         BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(16)),
  //     child: ListView.builder(
  //       primary: true,
  //       shrinkWrap: false,
  //       scrollDirection: Axis.horizontal,
  //       itemCount: widget.c.duyuruList[index].dosya.length,
  //       itemBuilder: (context, index2) {
  //         return IconButton(
  //           onPressed: () {
  //             urlAc(url: widget.c.duyuruList[index].dosya[index2]);
  //           },
  //           icon: Text("Ek" + (index2 + 1).toString(),
  //               style: TextStyle(color: Colors.white)),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget duyuruTarih(int index) {
    return Container(
      // padding: EdgeInsets.all(10),
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 10, right: 5),
      width: Get.width - 10,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(Tarih().gunAyYil(widget.c.duyuruList[index].createdAt),
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
          Text(widget.c.duyuruList[index].ekleyenAd,
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
      decoration: BoxDecoration(color: Renk.yesil, borderRadius: BorderRadius.circular(16)),
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
          if (widget.c.duyuruList[index].pin) SvgPicture.asset("asset/image/pin.svg"),
          Expanded(
            child: Text(
              widget.c.duyuruList[index].baslik,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Obx(() => duyuruOnay(index: index)),
        ],
      ),
    );
  }

  Widget duyuruOnay({required int index}) {
    ModelDuyuru duyuru = widget.c.duyuruList[index];
    if (duyuru.onayDurum == false) return SizedBox();
    bool onay = false;
    bool red = false;
    if (duyuru.veliOnayDurum.any((e) => e == co.veliSecilenOgrenci.value.data.adSoyad)) {
      onay = true;
      red = false;
    } else if (duyuru.veliRedDurum.any((e) => e == co.veliSecilenOgrenci.value.data.adSoyad)) {
      onay = false;
      red = true;
    }
    if (onay && red == false) {
      return Row(children: [
        IconButton(
            onPressed: () {
              toast(msg: "Daha önce onaylandı.");
            },
            icon: Icon(Icons.check)),
        IconButton(onPressed: null, icon: Icon(Icons.clear)),
      ]);
    }
    if (onay == false && red == true) {
      return Row(children: [
        IconButton(onPressed: null, icon: Icon(Icons.check)),
        IconButton(
            onPressed: () {
              toast(msg: "Daha önce reddedildi.");
            },
            icon: Icon(Icons.clear)),
      ]);
    }
    return Row(children: [
      IconButton(
          onPressed: () {
            duyuruUpdate(veliOnayDurum: "true", index: index);
          },
          icon: Icon(Icons.check)),
      IconButton(
          onPressed: () {
            duyuruUpdate(veliOnayDurum: "false", index: index);
          },
          icon: Icon(Icons.clear)),
    ]);
  }

  Future<void> duyuruUpdate({required String veliOnayDurum, required int index}) async {
    Get.context!.loaderOverlay.show();
    String? sonuc = await updateDuyuruVeliOnayDurum(
      token: cp.kullanici.token,
      body: {
        "_id": co.duyuruList[index].id,
        "ogrenciAdSoyad": co.veliSecilenOgrenci.value.data.adSoyad,
        "veliOnayDurum": veliOnayDurum,
      },
    );

    if (sonuc == null) {
      toast(msg: hataMesaj);
    } else {
      if (veliOnayDurum == "true") {
        co.duyuruList[index].veliOnayDurum.add(co.veliSecilenOgrenci.value.data.adSoyad);
      } else {
        co.duyuruList[index].veliRedDurum.add(co.veliSecilenOgrenci.value.data.adSoyad);
      }
      co.duyuruList.refresh();
      toast(msg: sonuc);
    }

    Get.context!.loaderOverlay.hide();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.c.duyuruList.clear();
    duyuruGetir = getDuyurular(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      userId: cp.kullanici.data.id,
      sinifId: cp.sinif.id,
    );
  }
}
