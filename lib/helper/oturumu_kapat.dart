import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/main.dart';
import 'package:get/get.dart';

import '../const/shared_pref_keys.dart';

Future<void> oturumuKapat() async {
  Shared().save(key: SharedKeys().telefon, value: "");
  Shared().save(key: SharedKeys().sifre, value: "");
  Get.offAll(() => Main());
}
