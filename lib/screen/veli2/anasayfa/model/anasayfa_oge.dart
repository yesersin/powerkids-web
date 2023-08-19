import 'package:flutter/material.dart';

import '../../../../controller/ogretmen/c_ogretmen.dart';

class AnasayfaOge {
  late COgretmen c;
  late String text;
  late String image;
  late Color color;
  late Widget sayfa;
  Function? komut;

  AnasayfaOge(
      {required this.c,
      required this.text,
      required this.image,
      required this.color,
      required this.sayfa,
      this.komut});
}
