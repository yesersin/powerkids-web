import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../const/mesaj_tip.dart';
import '../../../../helper/bildirim/send_push_message.dart';
import '../../../../helper/toast.dart';
import '../../../../model/web_api/kullanici/kullanici_notification.dart';
import '../../../../model/web_api/mesaj/mesaj_add_cevap.dart';
import '../../../../service/kullanici/kullanici_get_notification.dart';
import '../../../../service/mesaj/mesaj_add.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/hata_mesaj.dart';
import '../../../../static/yetki.dart';
import 'mesaj_olustur.dart';

void mesajEkle(
    {required COgretmen c,
    required String tip,
    required String mesajEsleId,
    required types.MessageType type,
    required TextEditingController mesajGonder,
    PlatformFile? file}) async {
  Get.context!.loaderOverlay.show();

  ModelMesajAddCevap? sonuc = await mesajAdd(
    okulId: cp.okul!.data.id,
    adSoyad: cp.kullanici.data.adSoyad,
    mesaj: mesajGonder.text,
    mesajEsleId: mesajEsleId,
    tip: tip,
    yetki: yetkiText,
    token: cp.kullanici.token,
    gid: cp.kullanici.data.id,
    file: file,
  );
  if (sonuc == null) {
    Get.context!.loaderOverlay.hide();
    toast(msg: hataMesaj);
    return;
  } else {
    toast(msg: "Mesaj gönderildi.");
    debugPrint("bildirim gödneriliyor");
    ModelKullaniciNotification? n =
        await kullaniciGetNotification(kullaniciId: c.mesajVeliId, token: cp.kullanici.token);
    if (n != null) {
      String notificationId = n.data.first.notificationId; //notification id al
      debugPrint("id bulundu:" + notificationId);
      sendPushMessage(notificationId, "Yeni mesaj", "Power Kids", TipMesaj.text);
    }

    types.Message message = mesajOlustur(
      type: type,
      id: sonuc.data.id,
      u: c.mesajGonderen,
      mesaj: mesajGonder.text,
      media: sonuc.data.media,
    );
    c.messages.insert(0, message);
    c.mesajList.insert(0, sonuc.data.mesajDatayaDonustur());
    mesajGonder.clear();
  }
  //duyuru ekle
  Get.context!.loaderOverlay.hide();
}
