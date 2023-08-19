import 'package:flutter/material.dart';

Widget menuYemekBaslik({required String baslik, VoidCallback? click}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 36),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          baslik,
          style: const TextStyle(
            color: Color(0xff1d1517),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(onPressed: click, icon: const Icon(Icons.arrow_circle_right_outlined)),
      ],
    ),
  );
}
