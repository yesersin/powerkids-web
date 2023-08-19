import 'package:com.powerkidsx/screen/veli2/widget/tabbar_simgeler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../static/cogretmen.dart';
import '../helper/sayfa_degistir.dart';

Widget veliTabBar({required PersistentTabController tabController}) {
  return PersistentTabView(
    Get.context!,
    controller: tabController,
    screens: co.veliSayfalar.value,
    onItemSelected: (index) async {
      if (index == 1) {
        //okunmayan mesaj sayısını sıfırla
        co.mesajOkunmayanSayi.value = 0;
      }
      // debugPrint("nav index:" + index.toString());
      // debugPrint("co.secilen index:" + co.sayfaSecilenIndex.value.toString());
      // debugPrint("tab index:" + tabController.index.toString());

      await veliSayfaDegistir(index: index, c: co, tabController: tabController);
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
    navBarStyle: NavBarStyle.style8, //veli tab bar değişebilir
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
