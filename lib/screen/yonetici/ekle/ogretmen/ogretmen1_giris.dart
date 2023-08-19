import 'package:com.powerkidsx/screen/yonetici/ekle/ogretmen/widget/ogretmen_bilgi_duzenle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/ogretmen/widget/ogretmen_sil_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../service/kullanici/kullanici_get_anything_ogretmen.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';

class YoneticiOgretmenEkleGiris extends StatefulWidget {
  const YoneticiOgretmenEkleGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiOgretmenEkleGiris> createState() => _YoneticiOgretmenEkleGirisState();
}

class _YoneticiOgretmenEkleGirisState extends State<YoneticiOgretmenEkleGiris> {
  List<AnythingVeliData> ogretmenList = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() => body());
  }

  Widget body() {
    if (co.yoneticiOgretmenGuncelle.value == false) {
      debugPrint("güncellenmedi");
      return ogretmenler();
    }
    // debugPrint("Güncelleniyor");
    return FutureBuilder(
      future: kullaniciGetAnythingOgretmenGetir(
        token: cp.kullanici.token,
        okulId: cp.okul!.data.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelKullaniciAnythingVeli?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        } else {
          if (snapshot.data == null) {
            return Center(child: Text(hataMesaj + " :(", style: TextStyle()));
          } else {
            ogretmenList = snapshot.data!.data;
            Future.delayed(Duration(milliseconds: 500), () {
              co.yoneticiOgretmenGuncelle.value = false;
            });

            return ogretmenler();
          }
        }
      },
    );
  }

  Widget ogretmenElement({required AnythingVeliData veli}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Color(0x55767372),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            title: ogretmenBilgiDuzenleBtn(ogretmenData: veli),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              ogretmenSilBtn(veliData: veli),
            ]),
          ),
          // Divider(
          //   height: 2,
          //   thickness: 2,
          // )
        ],
      ),
    );
  }

  Widget ogretmenler() {
    return SingleChildScrollView(
        key: PageStorageKey("velilist"),
        child: Column(children: ogretmenList.map((e) => ogretmenElement(veli: e)).toList()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    co.yoneticiOgretmenGuncelle.value = true;
  }
}
