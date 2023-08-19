import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../const/radius.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/izin.dart';
import '../../../../../helper/tarih.dart';
import '../../../../../helper/toast.dart';
import '../../../../component/custom/button.dart';
import '../../../../component/custom/text_field.dart';
import '../../../../static/cprogram.dart';
import '../../../ogretmen/anasayfa/duyuru/helper/duyuru_gonder.dart';

Widget yoneticiDuyuruEkleBtn() {
  return IconButton(
      onPressed: () {
        co.akisTarih.value = DateTime.now().add(Duration(days: 30));
        _sinifList.clear();
        for (int i = 0; i < cp.siniflar.data.length; i++) {
          _sinifList.add(cp.siniflar.data[i].sinifAdi);
        }
        _sinifList.insert(0, "Tüm sınıflar");
        _sinifGrp.selectIndex(0);
        Pencere().ac(
            content: duyuruEklePencere(c: co),
            context: Get.context!,
            baslik: "Duyuru Ekle",
            yukseklik: 470);
      },
      icon: Icon(
        Icons.add,
        color: Colors.red,
      ));
}

GroupButtonController _sinifGrp = GroupButtonController();
var _sinifList = [];

Widget duyuruEklePencere({required COgretmen c, Function? sayfaDegis}) {
  TextEditingController _baslik = TextEditingController();
  TextEditingController _aciklama = TextEditingController();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Textfield().text(
        controller: _baslik,
        hint: "Başlık",
        renk: Renk.maviAcik,
        onSubmit: (text) {},
      ),
      SizedBox(width: 0, height: 5),
      Textfield().text(
        controller: _aciklama,
        hint: "Başlık",
        renk: Renk.turuncu,
        maxLines: 10,
        minLines: 5,
        onSubmit: (text) {},
      ),
      SizedBox(width: 0, height: 5),
      GroupButton(
        controller: _sinifGrp,
        buttons: _sinifList,
        isRadio: true,
        maxSelected: _sinifList.length,
      ),
      SizedBox(width: 0, height: 5),
      Container(
        padding: EdgeInsets.all(3),
        decoration:
            BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(32)),
        child: Obx(
          () => c.duyuruEkleSecilenDosyalar.isEmpty
              ? InkWell(
                  onTap: () {
                    dosyaSecClick(c: c, fotograf: true);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.attach_file, color: Colors.white),
                      Text("Dosya Ekle", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              : Row(children: [
                  Text(c.duyuruEkleSecilenDosyalar.length.toString() + " dosya seçildi.",
                      style: TextStyle(color: Colors.white)),
                  IconButton(
                      onPressed: () {
                        c.duyuruEkleSecilenDosyalar.clear();
                      },
                      icon: Icon(Icons.delete, color: Colors.white)),
                ]),
        ),
      ),
      SizedBox(width: 0, height: 5),
      Row(
        children: [
          solIsimKutusu(c: c),
          SizedBox(width: 5, height: 0),
          sagTarihKutusu(c: c),
        ],
      ),
      SizedBox(width: 0, height: 5),
      Container(
        decoration:
            BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(32)),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Veli onaylasın mı?", style: TextStyle(color: Colors.white)),
              Obx(
                () => Checkbox(
                    value: c.duyuruVeliOnaylasinmi.value,
                    checkColor: Colors.white,
                    activeColor: Renk.kirmizi,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    onChanged: (value) {
                      c.duyuruVeliOnaylasinmi.value = value!;
                    }),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 0, height: 5),
      Container(
        decoration:
            BoxDecoration(color: Renk.griLogo, borderRadius: BorderRadius.circular(32)),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Veli", style: TextStyle(color: Colors.white)),
                  Obx(
                    () => Checkbox(
                        value: c.duyuruVeli.value,
                        checkColor: Colors.white,
                        activeColor: Renk.griLogo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        onChanged: (value) {
                          c.duyuruVeli.value = value!;
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Öğretmen", style: TextStyle(color: Colors.white)),
                  Obx(
                    () => Checkbox(
                        value: c.duyuruOgretmen.value,
                        checkColor: Colors.white,
                        activeColor: Renk.griLogo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        onChanged: (value) {
                          c.duyuruOgretmen.value = value!;
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Ebeveyn", style: TextStyle(color: Colors.white)),
                  Obx(
                    () => Checkbox(
                        value: c.duyuruEbeveyn.value,
                        checkColor: Colors.white,
                        activeColor: Renk.griLogo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        onChanged: (value) {
                          c.duyuruEbeveyn.value = value!;
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 0, height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: Get.width * 0.3,
            child: Buton().mavi(
                click: () async {
                  late String sinifId;
                  if (_sinifGrp.selectedIndex == 0) {
                    sinifId = "0000";
                  } else {
                    sinifId = cp.siniflar.data[_sinifGrp.selectedIndex ?? 0].id;
                  }

                  await duyuruGonder(
                    c: c,
                    baslik: _baslik,
                    aciklama: _aciklama,
                    sinifId: sinifId,
                  );
                },
                text: "Gönder"),
          ),
          SizedBox(width: 10, height: 0),
        ],
      ),
      SizedBox(width: 0, height: 15),
    ],
  );
}

Future<void> dosyaSecClick({required COgretmen c, required bool fotograf}) async {
  bool izin = await Izin().dosyalar(Get.context!);
  if (!izin) {
    print("izin verilmedi");
    toast(msg: "Dosya erişim izni alınamadı!");
    return;
  }
  debugPrint("xx1");
  FilePickerResult? file = await FilePicker.platform.pickFiles(
    allowCompression: true,
    allowMultiple: false,
    dialogTitle: "Dosya Seçin",
  );
  debugPrint("xx2");
  if (file == null) {
    debugPrint("xx3");
    return;
  }
  if (file.files.isNotEmpty) {
    debugPrint("xx4");
    for (int i = 0; i < 1; i++) {
      // if (c.duyuruEkleSecilenDosyalar.length >= 1) {
      //   debugPrint("xx5");
      //   continue;
      // }
      c.duyuruEkleSecilenDosyalar.add(PlatformFile(
        name: file.files[i].name,
        size: file.files[i].size,
        bytes: file.files[i].bytes,
      ));

      debugPrint("eklenen:" + file.files[i].name);
    }
  }
  debugPrint("xx6");
}

Widget sagTarihKutusu({required COgretmen c}) {
  return InkWell(
    onTap: () async {
      DateTime? date = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 30)));
      if (date != null) c.akisTarih.value = date;
    },
    child: Container(
      width: Get.width * 0.4,
      decoration: BoxDecoration(
          color: Renk.yesil,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(RadiusSabit.akisTextRadius),
              topRight: Radius.circular(RadiusSabit.akisTextRadius))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: Obx(
          () => Text(
            Tarih().gunAyYil(c.akisTarih.value),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget solIsimKutusu({required COgretmen c}) {
  return Container(
    width: Get.width * 0.4,
    decoration: BoxDecoration(
        color: Renk.yesil,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(RadiusSabit.akisTextRadius),
            topLeft: Radius.circular(RadiusSabit.akisTextRadius))),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Center(
      child: Text(
        "Son yayın tarihi",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    ),
  );
}
