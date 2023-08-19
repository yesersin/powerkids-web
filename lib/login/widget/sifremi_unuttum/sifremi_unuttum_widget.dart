import 'package:com.powerkidsx/login/widget/sifremi_unuttum/sifre_gonder_btn.dart';
import 'package:com.powerkidsx/login/widget/telefon_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../const/renk.dart';

Widget sifremiUnuttumWidget({required TextEditingController telefon}) {
  return Column(
    children: [
      Text(
        "Yeni şifre için lütfen numaranızı giriniz",
        style: TextStyle(color: Renk.griMetin),
      ),
      SizedBox(height: 25),
      telefonTextWidget(telefon: telefon),
      SizedBox(height: 25),
      sifremiGonderBtn(telefon: telefon),
      SizedBox(height: 25),
    ],
  );
}
