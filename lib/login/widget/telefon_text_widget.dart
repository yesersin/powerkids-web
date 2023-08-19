import 'package:flutter/material.dart';

import '../../const/renk.dart';

Widget telefonTextWidget({required TextEditingController telefon}) {
  return Container(
    decoration:
        BoxDecoration(color: Renk.griArkaplan, borderRadius: BorderRadius.circular(70)),
    child: TextField(
      keyboardType: TextInputType.number,
      cursorColor: Renk.griMetin,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.local_phone_outlined,
          color: Renk.griMetin,
        ),
        hintText: "Telefon Numarası",
        hintStyle: TextStyle(color: Renk.griMetin),
      ),
      style: TextStyle(color: Renk.griMetin),
      controller: telefon,
    ),
  );
}
