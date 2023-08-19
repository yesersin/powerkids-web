import 'package:flutter/material.dart';

Widget yuvarlak(
    {required String sayi, required String altMetin, required Color renk, Function? komut}) {
  return GestureDetector(
    onTap: () {
      if (komut != null) komut();
    },
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
                color: renk,
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, -2),
                    spreadRadius: -0,
                    blurRadius: 1.0,
                  ),
                  BoxShadow(
                    color: renk,
                    spreadRadius: -1.0,
                    blurRadius: 2.0,
                    // offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  sayi,
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ),
          ],
          alignment: Alignment.center,
        ),
        Text(altMetin, style: TextStyle(fontSize: 20)),
      ],
    ),
  );
}
