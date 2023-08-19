import 'package:com.powerkidsx/controller/login/c_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/renk.dart';

Widget sifreTextWidget({required TextEditingController sifre, required CLogin c}) {
  return Container(
    decoration:
        BoxDecoration(color: Renk.griArkaplan, borderRadius: BorderRadius.circular(70)),
    child: Obx(
      () => TextField(
        keyboardType: TextInputType.visiblePassword,
        cursorColor: Renk.griMetin,
        textInputAction: TextInputAction.done,
        enableSuggestions: false,
        obscureText: c.sifre.value,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Renk.griMetin,
          ),
          suffixIcon: IconButton(
            color: Renk.griMetin,
            icon: Icon(c.sifre.value ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              c.sifre.value = !c.sifre.value;
            },
          ),
          hintText: "Şifre",
          hintStyle: TextStyle(color: Renk.griMetin),
        ),
        style: TextStyle(color: Renk.griMetin),
        controller: sifre,
      ),
    ),
  );
}
