import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void imageKaydet(String url) async {
  var response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));

  print("1");

  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
      quality: 60, name: "powerkids${Random().nextInt(500000).toString()}");
  // print("2" + urlFile.path.toString());

  print("kaydedildi:" + result.toString());
}
