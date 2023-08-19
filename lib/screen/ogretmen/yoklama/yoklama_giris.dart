import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/yoklama_tip.dart';
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
import '../../../helper/bildirim/liste_bildirim_gonder.dart';
import '../../../helper/bildirim_gonder.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/kullanici/kullanici_notification.dart';
import '../../../model/web_api/yoklama/yoklama_add_cevap.dart';
import '../../../model/yoklama_btn.dart';
import '../../../service/kullanici/kullanici_get_notification_list.dart';
import '../../../service/sinif/sinif_ogrencileri_getir.dart';
import '../../../service/yoklama/yoklama_add.dart';
import '../../../static/cogretmen.dart';
import '../../../static/hata_mesaj.dart';

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
    if (co.ogrenciList.value != null && co.ogrenciList.value!.success != -1) {
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
        co.ogrenciList.value = snapshot.data!;
        return body();
      },
    );

    return body();
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
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            width: Get.width * 0.4,
                            child: Obx(() => yoklamaDropBtn()),
                          ),
                        ),
                        SizedBox(width: 10, height: 0),
                        Container(
                          width: Get.width * 0.4,
                          child: kaydetBtn(),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Obx(
                      () => (co.yoklamaSecilen.value.tip != "")
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
          if (co.yoklamaSecilen.value.tip == "") {
            toast(msg: "Lütfen seçim yapınız.");
            return;
          }
          co.yuklenenDosyaSayisi.value = 0;
          Get.context!.loaderOverlay.show(
              widget: Obx(() => yukleniyorYoklama(
                  co.yuklenenDosyaSayisi.value, co.ogrenciList.value!.data.length)));
          await yoklamaEkle();
          listeBildirimGonder(tip: '2', body: "Yoklama yapıldı.", pushBildirim: true);
          Get.context!.loaderOverlay.hide();
        },
        text: "Kaydet",
        svg: true,
        image: "asset/image/kaydet.svg");
  }

  Future<void> yoklamaEkle() async {
    String tip = "";
    String durum = "";
    for (int i = 0; i < co.ogrenciList.value!.data.length; i++) {
      if (co.yoklamaBeklemede[i] != "") {
        tip = YoklamaTip.beklemede;
        durum = "Beklemede";
      } else if (co.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
          co.yoklamaCheck[i] == false) {
        tip = YoklamaTip.okula_gelmedi;
        durum = "Okula Gelmedi";
      } else if (co.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
          co.yoklamaCheck[i] == true) {
        tip = YoklamaTip.okula_geldi;
        durum = "Okula Geldi";
      } else if (co.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
          co.yoklamaCheck[i] == false) {
        tip = YoklamaTip.teslim_edilmedi;
        durum = "Teslim Edilmedi";
      } else if (co.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
          co.yoklamaCheck[i] == true) {
        tip = YoklamaTip.teslim_edilmedi;
        durum = "Teslim Edildi";
      } else {
        tip = co.yoklamaSecilen.value.tip;
        durum = co.yoklamaSecilen.value.text;
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
        ogrenciId: co.ogrenciList.value!.data[i].id,
        ogretmenAdi: cp.kullanici.data.adSoyad,
        ogretmenId: cp.kullanici.data.id,
        yoklamaDurum: durum,
      );
      if (cevap == null) {
        toast(msg: hataMesaj);
      }
      co.yuklenenDosyaSayisi.value++;
      // await Future.delayed(Duration(milliseconds: 1000));
    }
    ModelKullaniciNotification? list = await getKullaniciNotificationList(
        sinifId: cp.sinif.id, okulId: cp.okul!.data.id, token: cp.kullanici.token);
    if (list != null) {
      bildirimGonder(list: list.data, tip: '2', pushBildirim: true, body: "Yoklama yapıldı.");
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
    if (co.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi) {
      co.yoklamaCheck.value =
          List.generate(co.ogrenciList.value!.data.length, (index) => true);
    } else {
      co.yoklamaCheck.value =
          List.generate(co.ogrenciList.value!.data.length, (index) => false);
    }
    co.yoklamaBeklemede.value =
        List.generate(co.ogrenciList.value!.data.length, (index) => "");
    for (int i = 0; i < co.ogrenciList.value!.data.length; i++) {
      list.add(kisi(
          image: co.ogrenciList.value!.data[i].fotografUrl,
          isim: co.ogrenciList.value!.data[i].adSoyad,
          index: i));
    }
    return Column(children: list);
  }

  Widget kisi({required String image, required String isim, required int index}) {
    return GestureDetector(
      onTap: () {
        if (co.yoklamaSecilen.value.tip != YoklamaTip.okula_geldi) return;
        if (co.yoklamaBeklemede[index] == "") {
          co.yoklamaBeklemede[index] = "beklemede";
        } else {
          co.yoklamaBeklemede[index] = "";
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
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
            Expanded(
              child: Text(
                isim,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            Obx(
              () => (co.yoklamaBeklemede[index] == "")
                  ? Obx(
                      () => Switch(
                        value: co.yoklamaCheck[index],
                        onChanged: (value) {
                          co.yoklamaCheck[index] = value;
                        },
                        activeColor: Renk.yesilSwitchAcik,

                        // inactiveColor: Colors.grey,
                      ),
                    )
                  : const Text("Beklemede", style: TextStyle()),
            ),
          ],
        ),
      ),
    );
  }

  Widget yoklamaDropBtn() {
    return DropdownButton2<ModelYoklamaBtn>(
      dropdownMaxHeight: 200,
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Colors.white,
      ),
      isExpanded: true,
      buttonPadding: const EdgeInsets.only(left: 10, right: 5),
      buttonDecoration: BoxDecoration(
          color: Renk.maviAcik,
          borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(3, 3),
            )
          ]),
      underline: const SizedBox(width: 0, height: 0),
      dropdownDecoration: BoxDecoration(
          color: Renk.maviAcik,
          borderRadius: BorderRadius.circular(RadiusSabit.dropdownRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(3, 3),
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
      value: co.yoklamaSecilen.value,
      onChanged: (value) async {
        co.yoklamaSecilen.value = value!;
        dropButonClick();
      },
      buttonHeight: 40,
      // buttonWidth: Get.width * 0.4,
      itemHeight: 40,
    );
  }

  dropButonClick() async {
    if (co.yoklamaSecilen.value.text == "") return;
    Get.context!.loaderOverlay.show();
    String? ogretmenId = cp.kullanici.data.yetki.brans ? cp.kullanici.data.id : null;
    ModelYoklama? yoklama = await yoklamaGetir(
      okulId: cp.okul!.data.id,
      sinifId: cp.sinif.id,
      dil: cp.dil,
      tip: co.yoklamaSecilen.value.tip,
      ay: Tarih.ay(),
      gun: Tarih.gun(),
      yil: Tarih.yil(),
      token: cp.kullanici.token,
      ogretmenId: ogretmenId,
    );

    if (co.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi) {
      co.yoklamaCheck.value =
          List.generate(co.ogrenciList.value!.data.length, (index) => true);
    } else {
      co.yoklamaCheck.value =
          List.generate(co.ogrenciList.value!.data.length, (index) => false);
    }
    co.yoklamaBeklemede.value =
        List.generate(co.ogrenciList.value!.data.length, (index) => "");

    if (yoklama != null) {
      //daha önce data girilmiş
      for (var element in yoklama.data) {
        int index = co.ogrenciList.value!.data
            .indexWhere((element2) => element.ogrenciId.id == element2.id);
        if (index != -1) {
          //sabah yoklamada "bekle" yapılmışsa göster
          if (co.yoklamaSecilen.value.tip == YoklamaTip.okula_geldi &&
              element.tip.toString() == YoklamaTip.beklemede) {
            debugPrint("0:$index");
            co.yoklamaBeklemede[index] = "beklemede";
          } else if (element.tip.toString() == YoklamaTip.okula_gelmedi) {
            debugPrint("1:$index");
            co.yoklamaCheck[index] = false;
          } else if (co.yoklamaSecilen.value.tip == YoklamaTip.teslim_edildi &&
              element.tip.toString() == YoklamaTip.teslim_edilmedi) {
            co.yoklamaCheck[index] = false;
          } else {
            co.yoklamaCheck[index] = true;
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
    Future.delayed(const Duration(milliseconds: 50), () {
      yoklamaBtnList.clear();
      yoklamaBtnList.add(ModelYoklamaBtn(text: "Seçiniz", tip: ""));
      if (cp.kullanici.data.yetki.admin || cp.kullanici.data.yetki.ogretmen) {
        yoklamaBtnList
            .add(ModelYoklamaBtn(text: "Sabah Yoklama", tip: YoklamaTip.okula_geldi));
        yoklamaBtnList
            .add(ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim));
        yoklamaBtnList.add(ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti));
        yoklamaBtnList
            .add(ModelYoklamaBtn(text: "Teslim Yoklama", tip: YoklamaTip.teslim_edildi));
      } else if (cp.kullanici.data.yetki.brans) {
        yoklamaBtnList
            .add(ModelYoklamaBtn(text: "Derse Girdim", tip: YoklamaTip.derse_girdim));
        yoklamaBtnList.add(ModelYoklamaBtn(text: "Ders Bitti", tip: YoklamaTip.ders_bitti));
      }

      co.yoklamaSecilen.value = yoklamaBtnList.first;
      debugPrint("xseçilen sınıf:${cp.sinif.id}");
    });
    ogrenciGetirServis = getSinifOgrencileri(
        token: cp.kullanici.token, okulId: cp.okul!.data.id, sinifId: cp.sinif.id);
  }
}
