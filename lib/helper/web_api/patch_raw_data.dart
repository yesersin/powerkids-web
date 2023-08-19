import 'dart:convert';

import 'package:com.powerkidsx/const/web_api/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> patchRawData(
    {required String adres,
    Map<String, String>? headers,
    required Map<String, dynamic> body}) async {
  //yanlış data gönderilse bile geriye response döner. null dönmesi için url erişilmez olmalı
  final uri = Uri.parse(baseUrl + adres);
  if (headers != null) headers.addAll({"content-type": "application/json"});
  http.Response? response;
  try {
    response = await http.patch(uri,
        headers: headers ?? {}, encoding: Encoding.getByName('utf-8'), body: jsonEncode(body));
  } catch (e) {
    //eğer url erişilemezse, data düzgün getirilemezse burası çalışır.
    debugPrint("hata post:" + e.toString());
  } finally {
    //geri null dönerse bağlantıyla ilgili bir hata olmuştur
    return response;
  }
}
