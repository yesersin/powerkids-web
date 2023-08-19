import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../helper/izin.dart';

Future<void> dersProgramDosyaSecClick({required COgretmen c}) async {
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
      c.dersProgramNotEkleSecilenDosyalar.add(PlatformFile(
        name: file.files[i].name,
        size: file.files[i].size,
        bytes: file.files[i].bytes,
      ));

      debugPrint("eklenen:" + file.files[i].name);
    }
  }
  debugPrint("xx6");
}
