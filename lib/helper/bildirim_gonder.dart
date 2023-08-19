import 'package:com.powerkidsx/helper/bildirim/send_push_message.dart';
import 'package:com.powerkidsx/model/web_api/kullanici/kullanici_notification.dart';
import 'package:com.powerkidsx/service/bildirim/bildirim_add.dart';
import 'package:com.powerkidsx/static/cprogram.dart';

Future<void> bildirimGonder({
  required List<KullaniciNotificationData> list,
  String title = "Powerkids App",
  required String tip,
  String? etkinlikId, //ilaç ekleme için
  String body = "Yeni bildirim",
  required bool pushBildirim,
}) async {
  for (var element in list) {
    if (pushBildirim) {
      sendPushMessage(element.notificationId, body, title, tip);
    }
    await bildirimAdd(
        okulId: cp.okul!.data.id,
        alanId: element.id,
        //kullanıcı id olması lazım
        gonderenId: cp.kullanici.data.id,
        alanNotificationId: element.notificationId,
        mesaj: body,
        tip: tip,
        etkinlikId: etkinlikId,
        token: cp.kullanici.token);
  }
}
