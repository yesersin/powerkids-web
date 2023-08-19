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
            return Column(
              children: [
                SizedBox(width: Get.width, height: 0),
                duyuruBaslik(index),
                duyuruAciklama(index),
                duyuruTarih(index),
                if (widget.c.duyuruList[index].dosya.isNotEmpty)
                  Positioned(top: 220, left: 5, child: ekDosya(index)),
                SizedBox(width: 0, height: 20),
              ],
            );
          }),
    );
  }

  Widget ekDosya(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width - 50,
      height: 30,
      decoration: BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(16)),
      child: ListView.builder(
        primary: true,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemCount: widget.c.duyuruList[index].dosya.length,
        itemBuilder: (context, index2) {
          return IconButton(
            onPressed: () {
              urlAc(url: widget.c.duyuruList[index].dosya[index2]);
            },
            icon: Text("Ek" + (index2 + 1).toString(), style: TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }

  Widget duyuruTarih(int index) {
    return Container(
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: Get.width - 50,
      color: Renk.yesil,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(Tarih().gunAyYil(widget.c.duyuruList[index].createdAt),
              style: const TextStyle(color: Colors.white)),
          Text(widget.c.duyuruList[index].ekleyenAd,
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget duyuruAciklama(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: Get.width - 50,
      height: 150,
      decoration: BoxDecoration(color: Renk.yesil, borderRadius: BorderRadius.circular(0)),
      child: SingleChildScrollView(
        child: Text(
          widget.c.duyuruList[index].aciklama * 50,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget duyuruBaslik(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Get.width - 10,
      decoration: BoxDecoration(color: Renk.turuncu, borderRadius: BorderRadius.circular(16)),
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
    widget.c.duyuruList.clear();
    duyuruGetir = getDuyurular(
      token: cp.kullanici.token,
      okulId: cp.okul!.data.id,
      userId: cp.kullanici.data.id,
      sinifId: cp.sinif.id,
    );
  }
}
