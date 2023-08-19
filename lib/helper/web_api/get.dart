import 'package:com.powerkidsx/const/web_api/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> getData({required String adres, Map<String, String>? headers}) async {
  //yanlış data gönderilse bile geriye response döner. null dönmesi için url erişilmez olmalı
  final uri = Uri.parse(baseUrl + adres);
  http.Response? response;
  try {
    response = await http.get(uri);
  } catch (e) {
    //eğer url erişilemezse, data düzgün getirilemezse burası çalışır.
    debugPrint("hata:" + e.toString());
  } finally {
    //geri null dönerse bağlantıyla ilgili bir hata olmuştur
    return response;
  }
}
