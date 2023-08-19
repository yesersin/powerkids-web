import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../component/custom/button.dart';
import '../../../../component/custom/text_field.dart';
import '../../../../component/pencere/uyari_pencere.dart';
import '../../../../const/radius.dart';
import '../../../../const/renk.dart';
import '../../../../helper/tarih.dart';
import '../../../../helper/toast.dart';
import 'helper/duyuru_gonder.dart';

Widget duyuruEkleBtn({required COgretmen c}) {
  return IconButton(
      onPressed: () {
        c.akisTarih.value = DateTime.now().add(Duration(days: 30));
        Pencere().ac(
            content: duyuruEklePencere(c: c),
            context: Get.context!,
            baslik: "Duyuru Ekle",
            yukseklik: 420);
      },
      icon: Icon(
        Icons.add,
        color: Colors.red,
      ));
}

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
        textRenk: Colors.white,
        hintRenk: Colors.white,
        onSubmit: (text) {},
      ),
      SizedBox(width: 0, height: 5),
      Textfield().text(
        controller: _aciklama,
        hint: "Başlık",
        renk: Renk.turuncu,
        textRenk: Colors.white,
        hintRenk: Colors.white,
        maxLines: 10,
        minLines: 5,
        onSubmit: (text) {},
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
                      Text("Dosya Ekle", style: TextStyle(color: Colors.white, fontSize: 10)),
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
      SizedBox(width: 0, height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              width: Get.width * 0.3,
              child: Buton().mavi(
                  click: () async {
                    await duyuruGonder(
                      c: c,
                      baslik: _baslik,
                      aciklama: _aciklama,
                    );
                  },
                  text: "Gönder"))
        ],
      )
    ],
  );
}

Future<void> dosyaSecClick({required COgretmen c, required bool fotograf}) async {
  bool izin = true; //web için izin istenmiyor
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
