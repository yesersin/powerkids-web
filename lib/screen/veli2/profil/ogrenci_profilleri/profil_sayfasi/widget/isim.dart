import 'package:flutter/material.dart';

Widget isim({required String isim}) {
  return Center(
    child: Text(isim,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        )),
  );
}
