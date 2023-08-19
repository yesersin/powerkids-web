import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_gelen.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/duyuru/widget/duyuru_duzenle_btn.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/duyuru/widget/duyuru_sil_btn.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../const/renk.dart';
import '../../../../controller/ogretmen/c_ogretmen.dart';
import '../../../../helper/toast.dart';
import '../../../../service/duyuru/duyuru_getir.dart';
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
    return Obx(
      () => ListView.builder(
          itemCount: widget.c.duyuruList.length,
          itemBuilder: (context, index) {
            if (widget.c.duyuruList[index].durum == false)
              return SizedBox(width: 0, height: 0);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Container(
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
        borderRadius: BorderRadius.circular(10),
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
          duyuruOnayRed(duyuru: widget.c.duyuruList[index]),
          duyuruSilBtn(index: index, duyuru: widget.c.duyuruList[index], c: widget.c),
          duyuruDuzenleBtn(
              index: index,
              duyuru: widget.c.duyuruList[index],
              c: widget.c,
              a: aciklamaDuzenle,
              b: baslikDuzenle),
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
                content: onayRed(list: duyuru.veliOnayDurum, durum: true),
                context: Get.context!,
                baslik: "Onaylayanlar");
            //Pencere().ac(content: Column(mainAxisAlignment: MainAxisAlignment.start, children: list), context: context, baslik: "Onaylayanlar");
          },
          icon: Icon(Icons.check)),
      IconButton(
          onPressed: () {
            List<Widget> listRed = [];
            for (int i = 0; i < duyuru.veliRedDurum.length; i++) {
              listRed.add(
                  Text(duyuru.veliRedDurum[i], style: TextStyle(color: Renk.numaraliRenk(i))));
            }
            Pencere().ac(
                content: onayRed(list: duyuru.veliRedDurum, durum: false),
                context: Get.context!,
                baslik: "Reddedenler");
            //Pencere().ac(content: Column(mainAxisAlignment: MainAxisAlignment.start, children: list), context: context, baslik: "Reddedenler");
          },
          icon: Icon(Icons.clear)),
    ]);
  }

  Widget onayRed({required List<String> list, required bool durum}) {
    List<Widget> wList = [];
    for (int i = 0; i < list.length; i++) {
      durum == true
          ? wList.add(onayRedList(isim: list[i], renk: Renk.numaraliRenk(i), durum: 1))
          : wList.add(onayRedList(isim: list[i], renk: Renk.numaraliRenk(i), durum: 0));
      wList.add(Divider(height: 2));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: wList,
    );
  }

  Widget onayRedList({required String isim, required Color renk, required int durum}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        durum == 1
            ? Icon(Icons.thumb_up_alt_outlined, color: renk)
            : Icon(Icons.thumb_down_alt_outlined, color: renk),
        Padding(
          padding: EdgeInsets.only(right: 10.0, bottom: 5.0), // 5px sağ boşluk
        ),
        SizedBox(width: 10),
        Expanded(child: Text(isim, style: TextStyle(color: renk))),
      ],
    );
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
