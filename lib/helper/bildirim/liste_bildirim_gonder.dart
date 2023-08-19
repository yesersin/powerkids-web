import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';

import '../../model/web_api/kullanici/kullanici_notification.dart';
import '../../service/kullanici/kullanici_get_notification_list.dart';
import '../../static/cprogram.dart';
import '../bildirim_gonder.dart';

Future<void> listeBildirimGonder({
  String title = "Power Kids App",
  required String tip,
  String? etkinlikId, //ilaç ekleme için
  String body = "Yeni bildirim",
  bool? ogretmen,
  required bool pushBildirim,
}) async {
  //ogretmen=true ise sadece öğretmenler getirilir
  ModelKullaniciNotification? list = await getKullaniciNotificationList(
      sinifId: cp.sinif.id,
      okulId: cp.okul!.data.id,
      token: cp.kullanici.token,
      ogretmen: ogretmen);
  if (list != null) {
    bildirimGonder(
      list: list.data,
      tip: tip,
      etkinlikId: etkinlikId,
      body: body,
      title: title,
      pushBildirim: pushBildirim,
    );
  } else {
    toast(msg: hataMesaj);
  }
}
