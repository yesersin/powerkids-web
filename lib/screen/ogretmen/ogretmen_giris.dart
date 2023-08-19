import 'package:com.powerkidsx/screen/ogretmen/helper/yeni_bildirim_kontrol.dart';
import 'package:com.powerkidsx/screen/ogretmen/widget/appbar_action_btn.dart';
import 'package:com.powerkidsx/screen/ogretmen/widget/appbar_title.dart';
import 'package:com.powerkidsx/screen/ogretmen/widget/tabbar.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/yeni_mesaj_sorgula_stream.dart';
import '../../model/web_api/kullanici/kullanici_notification.dart';
import '../../service/kullanici/kullanici_get_notification_list.dart';
import '../../service/mesaj/mesaj_okunmayan_sayi_getir.dart';
import '../../static/cogretmen.dart';
import 'anket/anket_kontrol.dart';
import 'helper/dogum_gunu_kontrol.dart';
import 'helper/geri_btn_click.dart';

class OgretmenGiris extends StatefulWidget {
  const OgretmenGiris({Key? key}) : super(key: key);

  @override
  State<OgretmenGiris> createState() => _OgretmenGirisState();
}

class _OgretmenGirisState extends State<OgretmenGiris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              geriBtnClick(c: co, tabController: co.ogretmenTabController);
            },
            icon: Icon(Icons.arrow_back)),
        title: Obx(() => appbarTitle(c: co)),
        actions: [
          if (1 != 1)
            IconButton(
                onPressed: () async {
                  ModelKullaniciNotification? s = await getKullaniciNotificationList(
                      okulId: cp.okul!.data.id,
                      sinifId: cp.sinif.id,
                      token: cp.kullanici.token);
                  s?.data.forEach((element) {
                    debugPrint(element.adSoyad);
                    debugPrint(element.notificationId);
                  });
                },
                icon: Icon(Icons.padding)),
          Obx(() => appbarActionBtn(c: co)),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return WillPopScope(
      onWillPop: () async {
        return geriBtnClick(c: co, tabController: co.ogretmenTabController);
      },
      child: Obx(() => tabBar(tabController: co.ogretmenTabController, c: co)),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 20), () async {
      co.ogretmenTabController.index = 0; //açılışta anasayfa gelsin
      yeniBildirimKontrol();
      anketKontrol();
      dogumGunuKontrol();
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
