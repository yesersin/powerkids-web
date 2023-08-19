import 'package:com.powerkidsx/screen/yonetici/ekle/ogrenci/widget/ogrenci_duzenle_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../component/pencere/evet_hayir.dart';
import '../../../../helper/ogrenci_sayisi.dart';
import '../../../../helper/toast.dart';
import '../../../../model/web_api/ogrenci/ogrenci_get_anything.dart';
import '../../../../service/ogrenci/ogrenci_get_anything.dart';
import '../../../../service/ogrenci/ogrenci_sil.dart';
import '../../../../static/cogretmen.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';
import '../../../ogretmen/profil/ogrenci_profilleri/profil_sayfasi/ogrenci_profil_ayrinti.dart';

class YoneticiOgrenciEkleGiris extends StatefulWidget {
  const YoneticiOgrenciEkleGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiOgrenciEkleGiris> createState() => _YoneticiOgrenciEkleGirisState();
}

List<OgrenciAnythingData> _ogrenciList = [];

class _YoneticiOgrenciEkleGirisState extends State<YoneticiOgrenciEkleGiris> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => body());
  }

  Widget body() {
    if (co.yoneticiOgrenciGuncelle.value == false) {
      return ogrenciler();
    }
    return FutureBuilder(
      future: ogrenciGetAnything(
        token: cp.kullanici.token,
        okulId: cp.okul!.data.id,
      ),
      builder: (BuildContext context, AsyncSnapshot<ModelOgrenciGetAnyThing?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
          return Center(child: Text(hataMesaj + " :(", style: TextStyle()));
        } else {
          _ogrenciList = snapshot.data!.data;
          Future.delayed(Duration(milliseconds: 500), () {
            co.yoneticiOgrenciGuncelle.value = false;
          });
          return ogrenciler();
        }
      },
    );
  }

  Widget ogrenciElement({required OgrenciAnythingData ogrenci, required int index}) {
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
            leading: Text(index.toString(), style: TextStyle(fontSize: 18)),
            title: GestureDetector(
                onTap: () {
                  co.profilSecilenOgrenci.value = ogrenci.toModelOgrenci();
                  co.yoneticiEkleSayfalari.add(OgretmenOgrenciProfilAyrinti(
                    c: co,
                    rxSayfa: co.yoneticiSayfalar,
                    index: 1,
                    sayfa: co.yoneticiEkleSayfalari,
                  ));
                  co.yoneticiSayfalar[1] = OgretmenOgrenciProfilAyrinti(
                    c: co,
                    rxSayfa: co.yoneticiSayfalar,
                    index: 1,
                    sayfa: co.yoneticiEkleSayfalari,
                  );
                },
                child: Text(ogrenci.adSoyad, style: TextStyle())),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                orenciDuzenleBtn(ogrenci: ogrenci),
                _silBtn(ogrenci: ogrenci),
              ],
            ),
          ),
          // Divider(height: 2, thickness: 2)
        ],
      ),
    );
  }

  Widget ogrenciler() {
    List<Widget> list = [];
    list.add(SizedBox(width: 0, height: 10));
    for (int i = 0; i < _ogrenciList.length; i++) {
      list.add(ogrenciElement(ogrenci: _ogrenciList[i], index: i + 1));
    }
    list.add(SizedBox(width: 0, height: 10));
    list.add(Text(
        (cp.ogrenciSayisi!.data.ogrenci).toString() +
            "/" +
            cp.ogrenciSayisi!.data.okul.toString(),
        style: TextStyle(fontSize: 14)));
    list.add(SizedBox(width: 0, height: 50));
    return SingleChildScrollView(
        key: PageStorageKey("ogrencilist"), child: Column(children: list));
  }

  Widget _silBtn({required OgrenciAnythingData ogrenci}) {
    return IconButton(
        onPressed: () async {
          bool? cevap =
              await PencereEvetHayir().sor(baslik: "Öğrenciyi silmek istiyor musunuz?");
          if (cevap == false) return;
          Get.context!.loaderOverlay.show();
          cevap = await ogrenciSil(id: ogrenci.id, token: cp.kullanici.token);
          co.yoneticiOgrenciGuncelle.value = true;
          debugPrint("1");
          if (cevap == null) {
            debugPrint("2");
            if (hataMesaj != "") toast(msg: hataMesaj);
            debugPrint("3");
            Get.context!.loaderOverlay.hide();
            return;
          }
          debugPrint("4");
          cp.ogrenciSayisi = await ogrenciSayisiYukle(); //öğrenci sayısını güncelle

          Get.context!.loaderOverlay.hide();
        },
        icon: Icon(Icons.delete));
  }
}
