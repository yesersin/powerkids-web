import 'package:flutter/material.dart';

import '../../../model/web_api/gunluk_akis.dart';
import '../../pencere/uyari_pencere.dart';

Widget akisAciklamaBtn(GunlukAkisData akis, BuildContext context) {
  return IconButton(
      onPressed: () {
        Pencere().ac(
            baslik: akis.baslik,
            content: Text(akis.aciklama, style: TextStyle(fontSize: 14)),
            context: context);
      },
      icon: const Icon(Icons.info_outline, color: Colors.white));
}
