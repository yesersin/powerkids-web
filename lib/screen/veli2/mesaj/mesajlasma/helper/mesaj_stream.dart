import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../../const/mesaj_tip.dart';
import '../../../../../model/web_api/mesaj/mesaj_veli_ogretmen.dart';
import '../../../../../service/mesaj/mesaj_get_son_mesaj.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/yetki.dart';

Future<void> sonMesajGetir() async {
  ModelMesajVeliOgretmen? sonuc = await mesajGetSonMesaj(
    token: cp.kullanici.token,
    mesajEsleId: co.mesajEsleId,
    yetki: yetkiText,
    gid: co.mesajGonderenId,
  );

  if (sonuc == null) {
    // toast(msg: hataMesaj);
    return;
  } else {
    // debugPrint("gelen mesaj:" + sonuc!.data.first.mesaj);
    sonuc.data.first.mesaj = sonuc.data.first.mesaj; //yeni mesaj
    var user;
    for (var mesaj in sonuc.data) {
      //burası açılacak
      if (co.messages.any((element) => element.id == mesaj.id)) {
        continue;
      }

      // mesaj.id = mesaj.id + Random().nextInt(500000).toString(); //geçici

      if (mesaj.yetki == "admin") {
        user = co.mesajAdmin;
      } else if (mesaj.gid == co.mesajGonderenId) {
        user = co.mesajGonderen;
      } else if (mesaj.gid == co.mesajVeliId) {
        user = co.mesajAlan;
      }
      if (mesaj.tip == TipMesaj.text) {
        debugPrint("1");
        co.messages.insert(
            0,
            types.TextMessage(
              id: mesaj.id,
              author: user,
              text: mesaj.mesaj,
              showStatus: true,
              status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
            ));
      } else if (mesaj.tip == TipMesaj.foto) {
        co.messages.insert(
            0,
            types.ImageMessage(
              id: mesaj.id,
              author: co.mesajGonderen,
              uri: mesaj.media,
              size: 200,
              name: "foto",
              showStatus: true,
              status: mesaj.goruldu ? types.Status.seen : types.Status.sent,
            ));
      } else if (mesaj.tip == TipMesaj.video) {
        debugPrint("3");

        co.messages.insert(
          0,
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
        debugPrint("4");

        co.messages.insert(
          0,
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
        co.messages.insert(
          0,
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
    if (sonuc != null) {
      co.messages.refresh();
    }
  }
}
