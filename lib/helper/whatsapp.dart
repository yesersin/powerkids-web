import 'dart:io';

import 'package:com.powerkidsx/helper/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsApp {
  void ac(String whatsapp) async {
    var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=Merhaba";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("Merhaba")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        toast(msg: "Whatsapp bulunamadı!");
      }
    } else {
      // android , web
      launchUrl(Uri.parse('https://wa.me/$whatsapp?text=Merhaba'),
          mode: LaunchMode.externalApplication);
      // if (await canLaunch(whatsappURlAndroid)) {
      //   await launch(whatsappURlAndroid);
      // } else {
      //   toast(msg: "Whatsapp bulunamadı!");
      // }
    }
  }
}
