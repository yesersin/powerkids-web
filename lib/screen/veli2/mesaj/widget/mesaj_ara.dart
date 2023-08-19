import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../../const/renk.dart';

TextEditingController _controller = TextEditingController();

Widget araContainer({required COgretmen c}) {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: araTextField(c: c),
    ),
  );
}

Widget araTextField({required COgretmen c}) {
  return TextField(
    controller: _controller,
    onChanged: (text) {
      c.mesajArananText.value = text;
    },
    decoration: InputDecoration(
      contentPadding: EdgeInsets.zero,
      icon: Icon(
        Icons.search,
        color: Renk.beyazMetin2,
      ),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintText: "Ara",
      fillColor: Colors.white,
    ),
  );
}
