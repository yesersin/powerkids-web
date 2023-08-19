import 'package:flutter/material.dart';

import '../../../../../const/renk.dart';
import 'kisi.dart';

Widget baslik({required String veliPhoto, required String adSoyad}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Renk.turuncu,
      borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
    ),
    child: kisi(
      image: veliPhoto,
      adSoyad: adSoyad,
    ),
  );
}
