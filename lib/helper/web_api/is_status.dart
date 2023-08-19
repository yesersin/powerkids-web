import 'dart:convert';

import 'package:http/http.dart' as http;

///response status durumunu kontrol eder.
///status code 200 ise true hata durumu var ise false döner.
bool isStatus(http.Response? response) {
  //status 200 mü
  if (response == null) return false; //url erişilemez olmuştur.

  if (jsonDecode(response.body)["success"] == 1) {
    return true;
  } else {
    return false;
  }
}

