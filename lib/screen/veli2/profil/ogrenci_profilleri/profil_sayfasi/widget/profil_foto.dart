import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../const/renk.dart';
import '../../../../../../helper/toast.dart';
import '../../../../../../model/web_api/ogrenci/ogrenci_update_cevap.dart';
import '../../../../../../service/ogrenci/ogrenci_up_profil_resim.dart';
import '../../../../../../static/cprogram.dart';
import '../../../../../../static/hata_mesaj.dart';

Widget ogrenciProfilFoto({required String url}) {
  return InkWell(
    onTap: () async {
      _click();
    },
    child: Center(
      child: Stack(
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(url),
            radius: 70,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Renk.turuncuCanli,
              ),
              child: IconButton(
                  onPressed: () {
                    _click();
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.yellow,
                  )),
            ),
          )
        ],
      ),
    ),
  );
}

Future<void> _click() async {
  late XFile? image;
  try {
    image = await ImagePicker().pickImage(imageQuality: 70, source: ImageSource.gallery);
  } catch (e) {
    toast(msg: "Seçilen dosya imaj değil:" + e.toString());
    return;
  }

  if (image == null) {
    return;
  }
  int size = await image.length();
  var bytes=await image.readAsBytes();
  PlatformFile secilenImaj = PlatformFile(
    name: image.name,
    bytes: bytes,
    size: size,
  );
  Get.context!.loaderOverlay.show();
  ModelOgrenciUpdateCevap? ogrenci = await ogrenciProfilResimUpdate(
    file: secilenImaj,
    id: co.veliSecilenOgrenci.value.data.id,
    okulId: cp.okul!.data.id,
    token: cp.kullanici.token,
  );

  if (ogrenci == null) {
    toast(msg: hataMesaj);
  } else {
    co.veliSecilenOgrenci.value.data.fotografUrl = ogrenci.data.fotografUrl;
    co.veliSecilenOgrenci.refresh();
    toast(msg: "Profil fotoğrafı güncellendi.");
  }

  Get.context!.loaderOverlay.hide();
}
