import 'dart:io';

import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UygulamaGuncelle extends StatefulWidget {
  const UygulamaGuncelle({Key? key}) : super(key: key);

  @override
  State<UygulamaGuncelle> createState() => _UygulamaGuncelleState();
}

class _UygulamaGuncelleState extends State<UygulamaGuncelle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: guncelle(),
    );
  }

  Widget guncelle() {
    String link = "";
    if (defaultTargetPlatform == TargetPlatform.android) {
      link = cp.besadim.data.first.androidUrl;
    } else if (Platform.isIOS) {
      link = cp.besadim.data.first.iosUrl;
    }
    return Center(
      child: Container(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Yeni sürüm yayınlandı. Lütfen güncelleyiniz!", style: TextStyle()),
              SizedBox(width: 0, height: 10),
              Buton().mavi(
                  click: () {
                    urlAc(url: link);
                  },
                  text: "Güncelle")
            ]),
      ),
    );
  }
}
