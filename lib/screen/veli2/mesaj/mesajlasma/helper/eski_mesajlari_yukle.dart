import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../../const/mesaj_tip.dart';
import '../../../../../model/web_api/mesaj/mesaj_veli_ogretmen.dart';
import '../../../../../service/mesaj/mesaj_getir.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/yetki.dart';

Future<void> eskiMesajlariYukle() async {
  debugPrint("tekrar yükle");
  // Get.context!.loaderOverlay.show();
  await Future.delayed(Duration(seconds: 1));
  co.mesajPage++;
  debugPrint("istenen sayfa:" + co.mesajPage.toString());
  ModelMesajVeliOgretmen? refreshMesaj = await mesajGetir(
    token: cp.kullanici.token,
    gid: cp.kullanici.data.id,
    yetki: yetkiText,
    mesajEsleId: co.mesajEsleId,
    page: co.mesajPage.toString(),
  );
  if (refreshMesaj == null) return;
  var user;
  for (var mesaj in refreshMesaj.data) {
    if (co.messages.any((element) => element.id == mesaj.id)) {
      continue;
    }

    if (mesaj.yetki == "admin") {
      debugPrint("admin mesajı");
      user = co.mesajAdmin;
    } else if (mesaj.gid == co.mesajGonderenId) {
      user = co.mesajGonderen;
    } else if (mesaj.gid == co.mesajVeliId) {
      user = co.mesajAlan;
    }
    if (mesaj.silindi) {
      co.messages.add(types.TextMessage(
        id: mesaj.id,
        author: user,
        text: "Bu mesaj silinmiştir.",
        showStatus: true,
        status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
      ));
    } else if (mesaj.tip == TipMesaj.text) {
      co.messages.add(types.TextMessage(
        id: mesaj.id,
        author: user,
        text: mesaj.mesaj,
        showStatus: true,
        status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
      ));
    } else if (mesaj.tip == TipMesaj.foto) {
      co.messages.add(types.ImageMessage(
        id: mesaj.id,
        author: co.mesajGonderen,
        uri: mesaj.media,
        size: 200,
        name: "foto",
        showStatus: true,
        status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
      ));
    } else if (mesaj.tip == TipMesaj.video) {
      co.messages.add(
        types.VideoMessage(
          id: mesaj.id,
          author: user,
          uri: mesaj.media,
          size: 200,
          name: mesaj.id,
          showStatus: true,
          status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
        ),
      );
    } else if (mesaj.tip == TipMesaj.belge) {
      co.messages.add(
        types.FileMessage(
          id: mesaj.id,
          author: user,
          uri: mesaj.media,
          size: 200,
          name: "Dosya",
          showStatus: true,
          status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
        ),
      );
    } else if (mesaj.tip == TipMesaj.ses) {
      co.messages.add(
        types.AudioMessage(
          duration: Duration(seconds: 60),
          id: mesaj.id,
          author: user,
          uri: mesaj.media,
          size: 200,
          name: "Ses",
          showStatus: true,
          status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
        ),
      );
    }
  }
}
