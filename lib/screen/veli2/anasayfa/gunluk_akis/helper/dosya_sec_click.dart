import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../helper/izin.dart';

Future<void> dosyaSecClick({required COgretmen c, required bool fotograf}) async {
  bool izin = await Izin().fotovideo(Get.context!);
  if (!izin) {
    print("izin verilmedi");
    toast(msg: "Galeri erişim izni alınamadı!");
    return;
  }

  if (fotograf) {
    debugPrint("1");
    late List<XFile> image;
    try {
      image = await ImagePicker().pickMultiImage(imageQuality: 70);
    } catch (e) {
      toast(msg: "Seçilen dosyalar imaj değil:" + e.toString());
      return;
    }

    if (image.isNotEmpty) {
      for (int i = 0; i < image.length; i++) {
        if (c.akisSecilenDosyalar.length >= 12) continue;
        int size = await image[i].length();
        var bytes = await image[i].readAsBytes();
        c.akisSecilenDosyalar.add(PlatformFile(
          name: image[i].name,
          bytes: bytes,
          size: size,
        ));
      }
    }
  } else {
    //video
    late XFile? video;
    debugPrint("2");

    try {
      video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    } catch (e) {
      toast(msg: "Seçilen dosyalar video değil:" + e.toString());
      debugPrint("Seçilen dosyalar imaj değil:" + e.toString());
      return;
    }
    if (video != null) {
      int size = await video.length();
      c.akisSecilenDosyalar.add(PlatformFile(name: video.name, path: video.path, size: size));
    }
  }
}
