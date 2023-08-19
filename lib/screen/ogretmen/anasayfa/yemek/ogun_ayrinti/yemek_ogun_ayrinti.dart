import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/const/ogun_tip.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/const/yoklama_tip.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/web_api/etkinlik_akis_add_cevap.dart';
import 'package:com.powerkidsx/model/web_api/yemek_menu_okul.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/yemek/ogun_ayrinti/widget/ogrenci_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/custom/yukleniyor.dart';
import '../../../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/sinif_ogrencileri.dart';
import '../../../../../model/web_api/yoklama/yoklama.dart';
import '../../../../../service/etkinlik_akis/etkinlik_akis_add.dart';
import '../../../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../../../service/yoklama/yoklama_getir.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';
import '../../../helper/geri_btn_click.dart';
import '../../../widget/yukleniyor_sayili.dart';

class OgunAyrinti extends StatefulWidget {
  COgretmen c;
  YemekOgun ogun;

  OgunAyrinti({Key? key, required this.c, required this.ogun}) : super(key: key);

  @override
  State<OgunAyrinti> createState() => _OgunAyrintiState();
}

class _OgunAyrintiState extends State<OgunAyrinti> {
  var ogrenciGetirServis;
  ModelYoklama? yoklama;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: Get.width * 0.4,
                    child: Buton().mavi(
                        click: () {},
                        renk: Renk.maviAcik,
                        text: Ogun.getOgun(widget.ogun.ogun.toString()))),
                SizedBox(width: Get.width * 0.05),
                SizedBox(width: 0, height: 20),
                SizedBox(
                  width: Get.width * 0.4,
                  child: kaydetBtn(),
                ),
              ],
            ),
            ogrenciKontrol(),
          ],
        ),
      ),
    );
  }

  Widget ogrenciKontrol() {
    return FutureBuilder(
      future: ogrenciGetirServis,
      builder: (BuildContext context, AsyncSnapshot<ModelSinifOgrencileri?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
          toast(msg: hataMesaj);
          return const Center(child: Text("Sınıfta öğrenci yok!", style: TextStyle()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Future.delayed(Duration(milliseconds: 10), () {
            widget.c.ogrenciList.value = snapshot.data!;
            widget.c.yemekMenuOgrenciBeklemede.value =
                List.generate(widget.c.ogrenciList.value!.data.length, (index) => false);
          });

          return yoklamaKontrol();
        }
        return Text("Yoklama hatası!");
      },
    );
  }

  Widget yoklamaKontrol() {
    String? ogretmenId = cp.kullanici.data.yetki.brans ? cp.kullanici.data.id : null;
    return FutureBuilder(
      future: yoklamaGetir(
        okulId: cp.okul!.data.id,
        sinifId: cp.sinif.id,
        dil: cp.dil,
        tip: YoklamaTip.okula_gelmedi,
        ay: widget.c.yemekSecilenTarih.value.month.toString(),
        gun: widget.c.yemekSecilenTarih.value.day.toString(),
        yil: widget.c.yemekSecilenTarih.value.year.toString(),
        token: cp.kullanici.token,
        ogretmenId: ogretmenId,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelYoklama?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        } else {
          //yoklama olmayabilir
          // if (snapshot.data == null) {
          //   toast(msg: hataMesaj);
          //   return Center(child: Text("Yoklamada hata oldu!", style: TextStyle()));
          // }
          yoklama = snapshot.data;
          return FutureBuilder(
            future: yemekOgrenciList(ogun: widget.ogun, c: widget.c, yoklama: yoklama),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return yukleniyor();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data!;
              } else {
                //hata
                return Text("Hata oluştu:" + hataMesaj, style: TextStyle());
              }
            },
          );
        }
      },
    );
  }

  Widget kaydetBtn() {
    return Buton().mavi(
        click: () async {
          widget.c.yuklenenDosyaSayisi.value = 0;
          Get.context!.loaderOverlay.show(
              widget: Obx(() => yukleniyorSayili(widget.c.yuklenenDosyaSayisi.value,
                  widget.c.yemekMenuOgrenciSecilen.length)));
          await ogunEkle();
          listeBildirimGonder(tip: "2", body: "Yemek durumu eklendi", pushBildirim: true);
          Get.context!.loaderOverlay.hide();
          toast(msg: "Öğün kaydedildi!");
          geriBtnClick(c: widget.c, tabController: widget.c.ogretmenTabController);
        },
        renk: Renk.maviAcik,
        text: "Kaydet",
        svg: true,
        image: "asset/image/kaydet.svg");
  }

  Future<void> ogunEkle() async {
    String tip = "";
    String durum = "";
    debugPrint("0");
    for (int i = 0; i < widget.c.yemekMenuOgrenciSecilen.length; i++) {
      widget.c.yuklenenDosyaSayisi.value++;
      //gelmeyen ve beklemede olanı atla
      if (widget.c.yemekMenuOgrenciSecilen[i].gelmedi ||
          widget.c.yemekMenuOgrenciBeklemede[i]) {
        await Future.delayed(Duration(milliseconds: 50)); //geçici
        continue;
      }
      ModelEtkinlikAkisAddCevap? cevap = await etkinlikAkisAdd(
        sinifId: cp.sinif.id,
        okulId: cp.okul!.data.id,
        token: cp.kullanici.token,
        dil: cp.dil,
        tip: widget.ogun.ogun.toString(),
        ogrenciId: widget.c.yemekMenuOgrenciSecilen[i].ogrenci.id,
        ogretmenAdi: cp.kullanici.data.adSoyad,
        etkinlikAdi: Ogun.getOgun(widget.ogun.ogun.toString()),
        etkinlikId: widget.ogun.id,
        tercih: widget.c.yemekMenuOgrenciSecilen[i].yemekDurumu(),
      );
      if (cevap == null) {
        toast(msg: hataMesaj);
      }

      // await Future.delayed(Duration(milliseconds: 1000));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
  }
}
