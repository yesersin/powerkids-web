import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../const/renk.dart';

Widget menuYemekOge(
    {required String isim, required Color renk, required String saat, required String image}) {
  return Padding(
    padding: const EdgeInsets.only(left: 36, right: 36, top: 8, bottom: 8),
    child: Row(
      children: [
        SvgPicture.asset(
          image,
          color: renk,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isim,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              saat,
              style: TextStyle(
                color: Renk.beyazMetin2,
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
