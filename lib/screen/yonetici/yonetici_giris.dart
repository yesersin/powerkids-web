import 'package:com.powerkidsx/screen/yonetici/helper/geri_btn_click.dart';
import 'package:com.powerkidsx/screen/yonetici/helper/yeni_bildirim_kontrol.dart';
import 'package:com.powerkidsx/screen/yonetici/widget/appbar_action_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/widget/appbar_title.dart';
import 'package:com.powerkidsx/screen/yonetici/widget/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/yeni_mesaj_sorgula_stream.dart';
import '../../service/mesaj/mesaj_okunmayan_sayi_getir.dart';
import '../../static/cogretmen.dart';
import '../../static/cprogram.dart';
import '../../static/yetki.dart';
import 'helper/dogum_gunu_kontrol.dart';

class YoneticiGiris extends StatefulWidget {
  const YoneticiGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiGiris> createState() => _YoneticiGirisState();
}

class _YoneticiGirisState extends State<YoneticiGiris> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              geriBtnClick(c: co, tabController: co.yoneticiTabController);
            },
            icon: Icon(Icons.arrow_back)),
        title: Obx(() => appbarTitle(c: co)),
        actions: [
          Obx(() => appbarActionBtn(c: co)),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return WillPopScope(
      onWillPop: () async {
        return geriBtnClick(c: co, tabController: co.yoneticiTabController);
      },
      child: Obx(() => yoneticiTabBar(tabController: co.yoneticiTabController, c: co)),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () async {
      co.yoneticiTabController.index = 0; //açılışta anasayfa gelsin

      yeniBildirimKontrol();
      // anketKontrol();
      dogumGunuKontrolKullanici();
      mesajOkunmayanSayiGetir(
        gid: cp.kullanici.data.id,
        yetki: yetkiText,
        token: cp.kullanici.token,
      ).then((value) {
        debugPrint("gelen sayı:" + value.toString());
        if (value != null) {
          co.mesajOkunmayanSayi.value = value.data!.first?.okunmayan ?? 0;
        }
      });
      //sürekli mesaj sayısı sorgulama
      mesajDinlemeDevam = true;
      yeniMesajSorgula().listen((event) {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    mesajDinlemeDevam = false; //mesaj sayısını sormayı durdur
  }
}
