import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';

import '../../../const/renk.dart';
import '../../../screen/ogretmen/anasayfa/gunluk_akis/helper/dosya_sec_click.dart';
import '../../custom/button.dart';

Widget dosyaSecBtn({required COgretmen c, required bool fotograf}) {
  return Buton().mavi(
      click: () async {
        if (fotograf && c.akisSecilenDosyalar.length >= 12) {
          toast(msg: "En fazla 12 fotoğraf seçebilirsiniz.");
          return;
        } else if (!fotograf && c.akisSecilenDosyalar.length >= 1) {
          toast(msg: "En fazla 1 video seçebilirsiniz.");
          return;
        }
        dosyaSecClick(c: c, fotograf: fotograf);
      },
      svg: true,
      image: "asset/image/upload_yukle.svg",
      renk: Renk.kirmizi,
      text: fotograf ? "Fotoğraf Seç" : "Video Seç");
}
