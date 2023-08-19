import 'package:com.powerkidsx/screen/ogretmen/widget/tabbar_simgeler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../controller/ogretmen/c_ogretmen.dart';
import '../helper/sayfa_degistir.dart';
import 'gunluk_akis_ekle_btn.dart';

Widget tabBar({required COgretmen c, required PersistentTabController tabController}) {
  return PersistentTabView(
    Get.context!,
    controller: tabController,
    screens: c.ogretmenSayfalar.value,
    onItemSelected: (index) async {
      if (index == 3) {
        //okunmayan mesaj sayısını sıfırla
        c.mesajOkunmayanSayi.value = 0;
      }
      // debugPrint("nav index:" + index.toString());
      // debugPrint("c.secilen index:" + c.sayfaSecilenIndex.value.toString());
      // debugPrint("tab index:" + tabController.index.toString());
      if (tabController.index == 2) {
        //ekle tıklanınca sayfa değişmesin

        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                content: fotografVideoYukle(
                    c: c,
                    sayfaDegis: () {
                      c.sayfaSecilenIndex.value = 0;
                      tabController.jumpToTab(0);
                    }),
              );
            });
        tabController.jumpToTab(c.sayfaSecilenIndex.value);
        return;
      }
      await sayfaDegisimi(index: index, c: c, tabController: tabController);
    },
    items: tabbarSimgeler(),
    confineInSafeArea: true,
    resizeToAvoidBottomInset: true,
    decoration: tabDecoration(),
    popAllScreensOnTapOfSelectedTab: true,
    handleAndroidBackButtonPress: false,
    //geri butonu ayarı
    popActionScreens: PopActionScreensType.once,
    screenTransitionAnimation: const ScreenTransitionAnimation(
      animateTabTransition: true,
      curve: Curves.ease,
      duration: Duration(milliseconds: 1300),
    ),
    navBarStyle: NavBarStyle.style15,
  );
}

NavBarDecoration tabDecoration() {
  return NavBarDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
    borderRadius: BorderRadius.circular(10.0),
    colorBehindNavBar: Colors.white,
  );
}
