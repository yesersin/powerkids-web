import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget etkinlikCard({
  required String saat,
  required String baslik,
  required String mesaj,
  required String ogretmenAd,
  required Color renk,
  Widget? altEkstra,
}) {
  return GestureDetector(
    onTap: () {
      toast(msg: ogretmenAd + " tarafından girildi.");
    },
    child: Container(
      margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      width: Get.width - 10,
      decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.circular(24)),
      // decoration: BoxDecoration(
      //   color: renk,
      //   borderRadius: BorderRadius.circular(24),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Color(0x3f000000),
      //       blurRadius: 4,
      //       offset: Offset(0, 4),
      //     ),
      //   ],
      // ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                saat,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            VerticalDivider(
              thickness: 3,
              color: Colors.white,
              // width: 20,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                      child: Text(
                        baslik,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow: TextOverflow.visible,
                        maxLines: 5,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(bottom: 10, top: 10, right: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(mesaj,
                                maxLines: 5,
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    if (altEkstra != null) altEkstra,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
