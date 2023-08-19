import 'package:flutter/material.dart';

import '../../../../../../component/custom/button.dart';
import '../../../../../../const/renk.dart';
import '../../../../../../model/web_api/sinif_ogrencileri.dart';

Widget ogrenciAdi(int index, ModelOgrenci ogrenci) {
  return Buton().mavi(
    click: null,
    renk: Renk.numaraliRenk(index),
    text: ogrenci.adSoyad,
  );
}
