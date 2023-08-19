import 'package:flutter/material.dart';

Widget yukleniyor({Color renk = Colors.blue}) {
  return Center(
    child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: renk,
        )),
  );
}
