import 'dart:io';

import 'package:flutter/foundation.dart';

class Internet {
  Future<bool> varmi() async {
    bool value = false;
    if (kIsWeb) return true;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      // await InternetAddress.lookup('apitr.powerkidsapp.com');
      // await InternetAddress.lookup('https://apitr.powerkidsapp.com:3002/besadim');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('internet bağlantısı var');
        value = true;
      }
    } on SocketException catch (_) {
      debugPrint('internet bağlantısı yok');
      value = false;
    }
    return value;
  }
}
