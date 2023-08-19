import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';

Widget etkinlikAkisListWidget({required COgretmen c}) {
  return Obx(
    () => ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: c.yoneticiEtkinlikAkis.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Renk.numaraliRenk(index),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(mainAxisSize: MainAxisSize.max, children: [
                  const SizedBox(width: 10, height: 0),
                  Text(Tarih().saatDkSn(c.yoneticiEtkinlikAkis[index].zaman),
                      style: TextStyle(color: Colors.white)),
                  const Divider(thickness: 3, color: Colors.white, height: 10),
                  Expanded(
                      child: Text(c.yoneticiEtkinlikAkis[index].etkinlikAdi,
                          style: TextStyle(color: Colors.white), textAlign: TextAlign.center)),
                ]),
                Container(
                  // height: 250,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Öğretmen:" +
                            c.yoneticiEtkinlikAkis[index].ogretmenAdi +
                            "\nÖğrenci Sayısı:" +
                            c.yoneticiEtkinlikAkis[index].ogrenciSayisi.toString(),
                        // textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
  );
}
