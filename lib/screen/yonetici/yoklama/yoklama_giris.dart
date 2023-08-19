import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/yoklama_tip.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/tarih.dart';
import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';
import 'package:com.powerkidsx/model/web_api/yoklama/yoklama.dart';
import 'package:com.powerkidsx/service/yoklama/yoklama_getir.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../const/renk.dart';
import '../../../const/radius.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/yoklama/yoklama_add_cevap.dart';
import '../../../model/yoklama_btn.dart';
import '../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../service/yoklama/yoklama_add.dart';
import '../../../static/hata_mesaj.dart';

late COgretmen c;
bool a = false;
List<ModelYoklamaBtn> yoklamaBtnList = [];
var ogrenciGetirServis;

class OgretmenYoklamaGiris extends StatefulWidget {
  OgretmenYoklamaGiris({Key? key}) : super(key: key);

  @override
  State<OgretmenYoklamaGiris> createState() => _OgretmenYoklamaGirisState();
}

class _OgretmenYoklamaGirisState extends State<OgretmenYoklamaGiris> {
  @override
  Widget build(BuildContext context) {
    Get.context!.loaderOverlay.hide();
    if (c.ogrenciList.value != null && c.ogrenciList.value!.success != -1) {
      return body();
    }
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
        c.ogrenciList.value = snapshot.data!;
        return body();
      },
    );

    return body();
  }

  Widget body() {
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

          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          child: Obx(() => yoklamaDropBtn()),
                        ),
                        Container(
                          width: Get.width * 0.4,
                          child: kaydetBtn(),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Obx(
                      () => (c.yoklamaSecilen.value.tip != "")
                          ? Obx(() => ogrenciListWidget())
                          : SizedBox(width: 0, height: 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget kaydetBtn() {
    return Buton().mavi(
        click: () async {
          if (c.yoklamaSecilen.value.tip == "") {
            toast(msg: "Lütfen seçim yapınız.");
            return;
          }
          c.yuklenenDosyaSayisi.value = 0;
          Get.context!.loaderOverlay.show(
              widget: Obx(() => yukleniyorYoklama(
                  c.yuklenenDosyaSayisi.value, c.ogrenciList.value!.data.length)));
          await yoklamaEkle();
          // listeBildirimGonder(tip: '2', body: "Yoklama1");
          Get.context!.loaderOverlay.hide();
        },
        text: "Kaydet",
        svg: true,
        image: "asset/image/kaydet.svg");
  }

  Future<void> yoklamaEkle() async {
    String tip = "";
    String durum = "";
    for (int i = 0; i < c.ogrenciList.value!.data.length; i++) {
      if (c.yoklamaBeklemede[i] != "") {
        tip = YoklamaTip.beklemede;
        durum = "Beklemede";
      } else if (c.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
          c.yoklamaCheck[i] == false) {
        tip = YoklamaTip.okula_gelmedi;
        durum = "Okula Gelmedi";
      } else if (c.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
          c.yoklamaCheck[i] == true) {
        tip = YoklamaTip.okula_geldi;
        durum = "Okula Geldi";
      } else if (c.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
          c.yoklamaCheck[i] == false) {
        tip = YoklamaTip.teslim_edilmedi;
        durum = "Teslim Edilmedi";
      } else if (c.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
          c.yoklamaCheck[i] == true) {
        tip = YoklamaTip.teslim_edilmedi;
        durum = "Teslim Edildi";
      } else {
        tip = c.yoklamaSecilen.value.tip;
        durum = c.yoklamaSecilen.value.text;
      }
      debugPrint(tip);
      debugPrint(durum);
      // continue;
      ModelYoklamaAddCevap? cevap = await yoklamaAdd(
        sinifId: cp.sinif.id,
        okulId: cp.okul!.data.id,
        token: cp.kullanici.token,
        dil: cp.dil,
        tip: tip,
        ogrenciId: c.ogrenciList.value!.data[i].id,
        ogretmenAdi: cp.kullanici.data.adSoyad,
        ogretmenId: cp.kullanici.data.id,
        yoklamaDurum: durum,
      );
      if (cevap == null) {
        toast(msg: hataMesaj);
      }
      c.yuklenenDosyaSayisi.value++;
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

  Widget ogrenciListWidget() {
    List<Widget> list = [];
    if (c.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi) {
      c.yoklamaCheck.value = List.generate(c.ogrenciList.value!.data.length, (index) => true);
    } else {
      c.yoklamaCheck.value = List.generate(c.ogrenciList.value!.data.length, (index) => false);
    }
    c.yoklamaBeklemede.value = List.generate(c.ogrenciList.value!.data.length, (index) => "");
    for (int i = 0; i < c.ogrenciList.value!.data.length; i++) {
      list.add(kisi(
          image: c.ogrenciList.value!.data[i].fotografUrl,
          isim: c.ogrenciList.value!.data[i].adSoyad,
          index: i));
    }
    return Column(children: list);
  }

  Widget kisi({required String image, required String isim, required int index}) {
    return GestureDetector(
      onTap: () {
        if (c.yoklamaSecilen.value.tip != YoklamaTip.okula_geldi) return;
        if (c.yoklamaBeklemede[index] == "") {
          c.yoklamaBeklemede[index] = "beklemede";
        } else {
          c.yoklamaBeklemede[index] = "";
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Color(0xff767372),
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: CachedNetworkImage(
                width: 96,
                height: 48,
                fit: BoxFit.cover,
                imageUrl: image,
              ),
            ),
            Text(
              isim,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22),
            ),
            Obx(
              () => (c.yoklamaBeklemede[index] == "")
                  ? Obx(
                      () => Switch(
                        value: c.yoklamaCheck[index],
                        onChanged: (value) {
                          c.yoklamaCheck[index] = value;
                        },
                        activeColor: Renk.yesilSwitchAcik,
                        // inactiveColor: Colors.grey,
                      ),
                    )
                  : Text("Beklemede", style: TextStyle()),
            ),
          ],
        ),
      ),
    );
  }

  Widget yoklamaDropBtn() {
    return DropdownButton2<ModelYoklamaBtn>(
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
      items: yoklamaBtnList
          .map((item) => DropdownMenuItem<ModelYoklamaBtn>(
                value: item,
                child: Text(
                  item.text,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: c.yoklamaSecilen.value,
      onChanged: (value) async {
        c.yoklamaSecilen.value = value!;
        dropButonClick();
      },
      buttonHeight: 40,
      // buttonWidth: Get.width * 0.4,
      itemHeight: 40,
    );
  }

  dropButonClick() async {
    if (c.yoklamaSecilen.value.text == "") return;
    Get.context!.loaderOverlay.show();
    String? ogretmenId = cp.kullanici.data.yetki.brans ? cp.kullanici.data.id : null;
    ModelYoklama? yoklama = await yoklamaGetir(
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      dil: cp.dil,
      tip: c.yoklamaSecilen.value.tip,
      ay: Tarih.ay(),
      gun: Tarih.gun(),
      yil: Tarih.yil(),
      token: cp.kullanici.token,
      ogretmenId: ogretmenId,
    );

    if (c.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi) {
      c.yoklamaCheck.value = List.generate(c.ogrenciList.value!.data.length, (index) => true);
    } else {
      c.yoklamaCheck.value = List.generate(c.ogrenciList.value!.data.length, (index) => false);
    }
    c.yoklamaBeklemede.value = List.generate(c.ogrenciList.value!.data.length, (index) => "");

    if (yoklama != null) {
      //daha önce data girilmiş
      for (var element in yoklama.data) {
        int index = c.ogrenciList.value!.data
            .indexWhere((element2) => element.ogrenciId.id == element2.id);
        if (index != -1) {
          //sabah yoklamada "bekle" yapılmışsa göster
          if (c.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
              element.tip.toString() == YoklamaTip.beklemede) {
            debugPrint("0:$index");
            c.yoklamaBeklemede[index] = "beklemede";
          } else if (element.tip.toString() == YoklamaTip.okula_gelmedi) {
            debugPrint("1:$index");
            c.yoklamaCheck[index] = false;
          } else if (c.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
              element.tip.toString() == YoklamaTip.teslim_edilmedi) {
            c.yoklamaCheck[index] = false;
          } else {
            c.yoklamaCheck[index] = true;
          }
        }
      }
    }

    Get.context!.loaderOverlay.hide();
  }

  @override
  void initState() {
    super.initState();
    //-admin ve öğretmene :okula geldi, okuldan gitti,derse girdim,teslim ettim, teslim etmedim.
    // branş öğretmenine:derse girdim,ders bitti seçenekleri sadece.
    //tip:0:beklemede,1 geldi, 2:gelmedi, 3:teslim edildi,4:teslim edilmedi,5:derse girdim,6:ders bitti.
    yoklamaBtnList.clear();
    yoklamaBtnList.add(ModelYoklamaBtn(text: "Seçiniz", tip: ""));
    if (cp.kullanici.data.yetki.admin || cp.kullanici.data.yetki.ogretmen) {
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Sabah Yoklama", tip: YoklamaTip.okula_geldi));
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim));
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti));
      yoklamaBtnList
          .add(ModelYoklamaBtn(text: "Teslim Yoklama", tip: YoklamaTip.teslim_edildi));
    } else if (cp.kullanici.data.yetki.brans) {
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim));
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti));
    }
    c = Get.find(tag: "cogretmen");
    c.yoklamaSecilen.value = yoklamaBtnList.first;
    debugPrint("seçilen sınıf:" + cp.sinif.id);
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
  }
}
