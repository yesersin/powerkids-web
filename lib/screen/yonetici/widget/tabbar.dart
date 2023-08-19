import 'package:com.powerkidsx/screen/yonetici/widget/tabbar_simgeler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../controller/ogretmen/c_ogretmen.dart';
import '../helper/yonetici_sayfa_degistir.dart';

Widget yoneticiTabBar({required COgretmen c, required PersistentTabController tabController}) {
  return PersistentTabView(
    Get.context!,
    controller: tabController,
    screens: c.yoneticiSayfalar.value,
    onItemSelected: (index) async {
      if (index == 2) {
        c.mesajOkunmayanSayi.value = 0;
      }
      await yoneticiSayfaDegisimi(index: index, c: c, tabController: tabController);
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
    navBarStyle: NavBarStyle.style8,
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
