import 'package:com.powerkidsx/helper/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/renk.dart';
import '../../helper/telefon_ara.dart';

Widget telefonWidget({required String tel, required String whatsapp}) {
  return Container(
    // margin: const EdgeInsets.only(left: 16),
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            telefonAra(tel);
          },
          child: Row(
            children: [
              SvgPicture.asset(
                "asset/image/telefon.svg",
                height: 24,
              ),
              SizedBox(width: 5),
              Text(
                tel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Renk.beyazMetin2,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () {
                WhatsApp().ac(whatsapp);
              },
              icon: Icon(
                Icons.message,
                color: Colors.green,
                size: 32,
              )),
        ),
        // Expanded(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       SizedBox(
        //           width: 100,
        //           height: 32,
        //           child: Buton().mavi(
        //               click: () {
        //                 telefonAra(no);
        //               },
        //               renk: Renk.turuncu,
        //               text: "Ara")),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}
