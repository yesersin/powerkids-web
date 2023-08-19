import 'package:com.powerkidsx/screen/yonetici/ekle/veli/widget/veli_bilgi_duzenle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/veli/widget/veli_ek_ogrenci_ekle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/veli/widget/veli_ek_veli_ekle_btn.dart';
import 'package:com.powerkidsx/screen/yonetici/ekle/veli/widget/veli_sil_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../model/web_api/kullanici/kullanici_anything_veli.dart';
import '../../../../service/kullanici/kullanici_get_anything_veli.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';

class YoneticiVeliEkleGiris extends StatefulWidget {
  const YoneticiVeliEkleGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiVeliEkleGiris> createState() => _YoneticiVeliEkleGirisState();
}

class _YoneticiVeliEkleGirisState extends State<YoneticiVeliEkleGiris> {
  List<AnythingVeliData> veliList = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() => body());
  }

  Widget body() {
    if (co.yoneticiVeliGuncelle.value == false) {
      debugPrint("güncellenmedi");
      return veliler();
    }
    debugPrint("Güncelleniyor");
    return FutureBuilder(
      future: kullaniciGetAnythingVeliGetirX(
        token: cp.kullanici.token,
        okulId: cp.okul!.data.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelKullaniciAnythingVeli?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          return Center(child: Text(hataMesaj + " :(", style: TextStyle()));
        } else {
          veliList = snapshot.data!.data;
          Future.delayed(Duration(milliseconds: 500), () {
            co.yoneticiVeliGuncelle.value = false;
          });
          return veliler();
        }
      },
    );
  }

  Widget veliElement({required AnythingVeliData veli}) {
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
            title: veliBilgiDuzenleBtn(veliData: veli),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              veliEkVeliEkleBtn(veliData: veli),
              SizedBox(width: 5, height: 0),
              veliEkOgrenciEkleBtn(veliData: veli),
              SizedBox(width: 5, height: 0),
              veliSilBtn(veliData: veli),
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

  Widget veliler() {
    return SingleChildScrollView(
        key: PageStorageKey("velilist"),
        child: Column(children: veliList.map((e) => veliElement(veli: e)).toList()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    co.yoneticiVeliGuncelle.value = true;
  }
}
