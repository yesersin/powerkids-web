import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget yoklamaCard({
  required String saat,
  required String mesaj,
  required String yoklamaDurum,
  required Color renk,
}) {
  return Container(
    margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
    width: Get.width - 10,
    decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.circular(24)),
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
          const VerticalDivider(thickness: 3, color: Colors.white),
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 5, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mesaj,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),

                      // overflow: TextOverflow.,
                      // maxLines: 5,
                    ),
                    Text(
                      yoklamaDurum,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
