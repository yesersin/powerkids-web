import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../const/renk.dart';

List<PersistentBottomNavBarItem> tabbarSimgeler() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Anasayfa"),
      activeColorPrimary: Renk.turuncu,
      inactiveColorPrimary: Renk.kahveNavBar,
    ),
    PersistentBottomNavBarItem(
      // icon: SvgPicture.asset(
      //   "asset/image/yonetici_logo.svg",
      //   color: Colors.black,
      // ),
      icon: Icon(CupertinoIcons.checkmark_shield),
      title: ("Yoklama"),
      activeColorPrimary: Renk.turuncu,
      inactiveColorPrimary: Renk.kahveNavBar,
    ),
    PersistentBottomNavBarItem(
      inactiveIcon: Icon(
        CupertinoIcons.add,
        color: Colors.green,
      ),
      icon: Icon(
        CupertinoIcons.add,
        color: Colors.yellow,
      ),
      // title: ("Fotoğraf"),
      activeColorPrimary: Renk.beyazArkaplan,
      inactiveColorPrimary: Renk.beyazArkaplan,
    ),
    PersistentBottomNavBarItem(
      icon: Obx(() {
        return (co.mesajOkunmayanSayi.value != 0)
            ? Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(co.mesajOkunmayanSayi.value.toString(),
                    style: TextStyle(color: Colors.white)),
              )
            : Icon(Icons.message_rounded);
      }),
      title: ("Mesaj"),
      activeColorPrimary: Renk.turuncu,
      inactiveColorPrimary: Renk.kahveNavBar,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: ("Profil"),
      activeColorPrimary: Renk.turuncu,
      inactiveColorPrimary: Renk.kahveNavBar,
    ),
  ];
}
