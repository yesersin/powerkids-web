import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/model/web_api/etkinlik_akis_add_cevap.dart';
import 'package:com.powerkidsx/screen/veli2/anasayfa/etkinlikler/widget/etkinlik_ogrenci_list.dart';
import 'package:com.powerkidsx/service/etkinlik/okul_etkinlik_getir.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../const/radius.dart';
import '../../../../const/renk.dart';
import '../../../../const/yoklama_tip.dart';
import '../../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../../helper/tarih.dart';
import '../../../../helper/toast.dart';
import '../../../../model/etkinlik_ekle.dart';
import '../../../../model/web_api/etkinlik.dart';
import '../../../../model/web_api/sinif_ogrencileri.dart';
import '../../../../model/web_api/yoklama/yoklama.dart';
import '../../../../service/etkinlik_akis/etkinlik_akis_add.dart';
import '../../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../../service/yoklama/yoklama_getir.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';

bool first = false;

class OgretmenEtkinliklerGiris extends StatefulWidget {
  COgretmen c;

  OgretmenEtkinliklerGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenEtkinliklerGiris> createState() => _OgretmenEtkinliklerGirisState();
}

class _OgretmenEtkinliklerGirisState extends State<OgretmenEtkinliklerGiris> {
  var ogrenciGetirServis;
  ModelYoklama? yoklama;
  ModelEtkinlik? etkinlik;

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
      child: Column(
        children: [
          Container(width: Get.width - 10),
          // CalendarAppBar(
          //   backButton: false,
          //   accent: Renk.turuncu,
          //   black: Renk.turuncu,
          //   padding: 10,
          //   fullCalendar: false,
          //   locale: "tr",
          //   onDateChanged: (value) => print(value),
          //   firstDate: DateTime.now().subtract(Duration(days: 15)),
          //   lastDate: DateTime.now(),
          // ),
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: etkinlikYukle(),
          ),
        ],
      ),
    ));
  }

  Widget etkinlikYukle() {
    return FutureBuilder(
      future:
          getOkulEtkinlik(okulId: cp.okul!.data.id, token: cp.kullanici.token, dil: cp.dil),
      builder: (BuildContext context, AsyncSnapshot<ModelEtkinlik?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        etkinlik = snapshot.data;
        if (etkinlik == null) {
          return Text(hataMesaj, style: TextStyle());
        }
        widget.c.etkinlikler = etkinlik!.data;
        widget.c.etkinlikler.insert(
            0,
            Etkinlik(
                id: "",
                okulId: "",
                tip: "",
                seciliSecenek: "",
                etkinlikAdi: "Seçiniz",
                secenekBir: "",
                secenekIki: "",
                secenekUc: "",
                secenekDort: "",
                dil: "",
                durum: true,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                v: 0));
        widget.c.seciliEtkinlik.value = widget.c.etkinlikler[0];
        return Obx(() => etkinlikDrop());
      },
    );
  }

  Widget ogrenciKontrol() {
    if (widget.c.ogrenciList.value!.success != -1) {
      debugPrint("öğrenci listesi var");
      widget.c.ogrenciList.value!.data.forEach((element) {
        debugPrint(element.adSoyad);
      });
      widget.c.etkinliklerOgrenciSecilen.value = List.generate(
          widget.c.ogrenciList.value!.data.length,
          (index) => ModelEtkinlikEkleOgrenci(
              ogrenciId: widget.c.ogrenciList.value!.data[index].id,
              ogrenci: widget.c.ogrenciList.value!.data[index],
              tercih: widget.c.seciliEtkinlik.value.etkinlikAdi));
      return yoklamaKontrol();
    }
    debugPrint("öğrenci listesi yükleniyor");
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
        widget.c.ogrenciList.value = snapshot.data!;
        widget.c.etkinliklerOgrenciSecilen.value = List.generate(
            widget.c.ogrenciList.value!.data.length,
            (index) => ModelEtkinlikEkleOgrenci(
                ogrenciId: widget.c.ogrenciList.value!.data[index].id,
                ogrenci: widget.c.ogrenciList.value!.data[index],
                tercih: widget.c.seciliEtkinlik.value.etkinlikAdi));
        return yoklamaKontrol();
      },
    );
  }

  Widget yoklamaKontrol() {
    if (yoklama != null) {
      debugPrint("yoklama listesi var");
      return Obx(() => etkinlikOgrenciList(
          c: widget.c, yoklama: yoklama, etkinlik: widget.c.seciliEtkinlik.value));
    }
    String? ogretmenId = cp.kullanici.data.yetki.brans ? cp.kullanici.data.id : null;
    return FutureBuilder(
      future: yoklamaGetir(
        okulId: cp.okul!.data.id,
        sinifId: cp.sinif.id,
        dil: cp.dil,
        tip: YoklamaTip.okula_gelmedi,
        ay: Tarih.ay(),
        gun: Tarih.gun(),
        yil: Tarih.yil(),
        token: cp.kullanici.token,
        ogretmenId: ogretmenId,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelYoklama?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }

        yoklama = snapshot.data;
        debugPrint("yoklama:" + yoklama.toString());
        return Obx(
          () => etkinlikOgrenciList(
              c: widget.c, yoklama: yoklama, etkinlik: widget.c.seciliEtkinlik.value),
        );
      },
    );
  }

  Widget etkinlikDrop() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton2<Etkinlik>(
                dropdownMaxHeight: 200,
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
                isExpanded: true,
                buttonPadding: EdgeInsets.only(left: 10, right: 5),
                buttonDecoration: BoxDecoration(
                    color: Renk.maviAcik,
                    borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(3, 3),
                      )
                    ]),
                dropdownDecoration: BoxDecoration(
                    color: Renk.maviAcik,
                    borderRadius: BorderRadius.circular(RadiusSabit.dropdownRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(3, 3),
                      )
                    ]),
                items: widget.c.etkinlikler
                    .map((item) => DropdownMenuItem<Etkinlik>(
                          value: item,
                          child: Text(
                            item.etkinlikAdi,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: widget.c.seciliEtkinlik.value,
                onChanged: (value) {
                  widget.c.seciliEtkinlik.value = value!;
                },
                buttonHeight: 40,
                // buttonWidth: Get.width * 0.4,
                itemHeight: 40,
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 40,
              width: Get.width * 0.3,
              child: Buton().mavi(
                  click: () async {
                    if (widget.c.seciliEtkinlik.value.tip == "") {
                      toast(msg: "Lütfen seçim yapınız.");
                      return;
                    }
                    widget.c.yuklenenDosyaSayisi.value = 0;
                    Get.context!.loaderOverlay.show(
                        widget: Obx(() => yukleniyorYoklama(widget.c.yuklenenDosyaSayisi.value,
                            widget.c.ogrenciList.value!.data.length)));
                    await etkinlikEkle();
                    listeBildirimGonder(
                        tip: '2', body: "Etkinlik Yapıldı", pushBildirim: true);
                    Get.context!.loaderOverlay.hide();
                  },
                  text: "Kaydet",
                  svg: true,
                  image: "asset/image/kaydet.svg"),
            )
          ],
        ),
        Obx(() => (widget.c.seciliEtkinlik.value.id != ""
            ? ogrenciKontrol()
            : SizedBox(width: 0, height: 0))),
      ],
    );
  }

  Future<void> etkinlikEkle() async {
    String tip = "";
    String durum = "";
    debugPrint("0");
    for (int i = 0; i < widget.c.ogrenciList.value!.data.length; i++) {
      if (widget.c.etkinliklerOgrenciSecilen[i].beklemede ||
          widget.c.etkinliklerOgrenciSecilen[i].gelmedi) {
        widget.c.yuklenenDosyaSayisi.value++;
        continue;
      }
      ModelEtkinlikAkisAddCevap? cevap = await etkinlikAkisAdd(
        sinifId: cp.sinif.id,
        okulId: cp.okul!.data.id,
        token: cp.kullanici.token,
        dil: cp.dil,
        tip: "etkinlik",
        ogrenciId: widget.c.ogrenciList.value!.data[i].id,
        ogretmenAdi: cp.kullanici.data.adSoyad,
        etkinlikId: widget.c.seciliEtkinlik.value.id,
        tercih: widget.c.etkinliklerOgrenciSecilen[i].tercih,
        etkinlikAdi: widget.c.seciliEtkinlik.value.etkinlikAdi,
      );
      if (cevap == null) {
        toast(msg: hataMesaj);
      }
      widget.c.yuklenenDosyaSayisi.value++;
      // await Future.delayed(Duration(milliseconds: 1000));
    }
  }

  Widget yukleniyorYoklama(int yuklenen, int toplam) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 0, height: 10),
              Text(
                yuklenen.toString() +
                    "/" +
                    toplam.toString() +
                    "\n Yüklemi işlemi devam ediyor.\nLütfen bekleyin.",
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
  }
}
