import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/gunluk_akis/akis_fotograf_album.dart';
import '../../../../../static/cogretmen.dart';

List<Widget> akisFoto({required List<String> url}) {
  return [
    InkWell(
      onTap: () async {
        await showDialog(
            context: Get.context!,
            builder: (context) {
              return fotoAlbum(url: url, c: co);
            });
      },
      child: SizedBox(
        width: Get.width - 50,
        height: 120,
        child: Icon(
          Icons.image,
          size: 100,
        ),
      ),
    )
  ];
}
