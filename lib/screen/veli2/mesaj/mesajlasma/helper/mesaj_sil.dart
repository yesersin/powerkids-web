import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/pencere/uyari_pencere.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/mesaj/mesaj_add_cevap.dart';
import '../../../../../service/mesaj/mesaj_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Future<void> mesajSil({required types.Message message}) async {
  return;
  debugPrint(message.id);
  Pencere().ac(
      yukseklik: 125,
      content: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mesajı silmek istiyor musunuz?", style: TextStyle()),
          MaterialButton(
              color: Colors.red,
              onPressed: () async {
                Get.context!.loaderOverlay.show();
                MesajAddData? sonuc = await mesajUpdate(
                  token: cp.kullanici.token,
                  id: message.id,
                  body: {"silindi": "true"},
                );
                if (sonuc == null) {
                  Get.context!.loaderOverlay.hide();
                  toast(msg: hataMesaj);
                  return;
                } else {
                  toast(msg: "Mesaj silindi.");
                  co.messages.value.removeWhere((element) => element.id == message.id);

                  co.messages.refresh();
                  Get.back();
                }
                Get.context!.loaderOverlay.hide();
              },
              child: Text("Sil")),
        ],
      ),
      context: Get.context!);
}
