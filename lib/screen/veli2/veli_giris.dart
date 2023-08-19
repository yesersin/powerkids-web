import 'package:com.powerkidsx/screen/veli2/helper/yeni_bildirim_kontrol.dart';
import 'package:com.powerkidsx/screen/veli2/widget/appbar_action_btn.dart';
import 'package:com.powerkidsx/screen/veli2/widget/appbar_title.dart';
import 'package:com.powerkidsx/screen/veli2/widget/tabbar.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/yeni_mesaj_sorgula_stream.dart';
import '../../service/mesaj/mesaj_okunmayan_sayi_getir.dart';
import '../../static/cogretmen.dart';
import '../veli2/helper/geri_btn_click.dart';
import 'anket/anket_kontrol.dart';

class VeliGiris extends StatefulWidget {
  const VeliGiris({Key? key}) : super(key: key);

  @override
  State<VeliGiris> createState() => _VeliGirisState();
}

class _VeliGirisState extends State<VeliGiris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              veliGeriBtnClick(c: co, tabController: co.ogretmenTabController);
            },
            icon: const Icon(Icons.arrow_back)),
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
        return veliGeriBtnClick(c: co, tabController: co.veliTabController);
      },
      child: Obx(() => veliTabBar(tabController: co.veliTabController)),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50), () async {
      co.veliTabController.index = 0; //açılışta anasayfa gelsin
      yeniBildirimKontrol();
      anketKontrol();
      // dogumGunuKontrol();
      //açılınca hemen mesaj sayısını getir
      mesajOkunmayanSayiGetir(
              gid: cp.kullanici.data.id, yetki: yetkiText, token: cp.kullanici.token)
          .then((value) {
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
