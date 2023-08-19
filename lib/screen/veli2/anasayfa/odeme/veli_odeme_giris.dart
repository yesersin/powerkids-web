import 'package:com.powerkidsx/screen/veli2/anasayfa/odeme/widget/odeme_element.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/material.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../model/web_api/veli/veli_borc.dart';
import '../../../../service/veli/veli_borc_getir.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';

class VeliOdemeGiris extends StatefulWidget {
  const VeliOdemeGiris({Key? key}) : super(key: key);

  @override
  State<VeliOdemeGiris> createState() => _VeliOdemeGirisState();
}

class _VeliOdemeGirisState extends State<VeliOdemeGiris> {
  late ModelVeliBorc borc;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: veliBorcGetir(
        token: cp.kullanici.token,
        ogrenciId: co.veliSecilenOgrenci.value.data.id,
        okulId: cp.okul!.data.id,
        veliId: cp.kullanici.data.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelVeliBorc?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          return Text(hataMesaj, style: TextStyle());
        }
        borc = snapshot.data!;
        return body();
      },
    );
    return body();
  }

  Widget body() {
    List<Widget> list = [];
    for (int i = 0; i < borc.data.length; i++) {
      list.add(odemeElement(data: borc.data[i], index: i));
      list.add(SizedBox(width: 0, height: 10));
    }
    return SingleChildScrollView(
      child: Column(
        children: list,
      ),
    );
  }
}
