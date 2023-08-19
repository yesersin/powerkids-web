import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/renk.dart';

Widget okulAdi({required String isim}) {
  Color color = Renk.rasgeleRenk();
  return Column(
    children: [
      Row(children: [
        SvgPicture.asset(
          "asset/image/okul.svg",
          color: color,
        ),
        SizedBox(width: 20, height: 0),
        Text(isim,
            style: TextStyle(
              color: color,
            ))
      ]),
      SizedBox(width: 0, height: 10),
      Divider(
        height: 3,
        color: color,
      ),
      SizedBox(width: 0, height: 10),
    ],
  );
}
