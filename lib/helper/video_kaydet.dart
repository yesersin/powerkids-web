import 'dart:io';

import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/static/cogretmen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> videoKaydet(String url) async {
  final appDocDirectory = await getAppDocDirectory();

  final finalVideoPath = join(
    appDocDirectory.path,
    'powerkids-${DateTime.now().millisecondsSinceEpoch}.mp4',
  );

  final dio = Dio();

  await dio.download(
    url,
    finalVideoPath,
    onReceiveProgress: (actualBytes, totalBytes) {
      final percentage = actualBytes / totalBytes * 100;
      if (percentage.toInt() == 100) {
        co.video.value = 0;
        toast(msg: "Video indirildi!");
      } else {
        co.video.value = percentage.toInt();
      }
    },
  );

  await saveDownloadedVideoToGallery(videoPath: finalVideoPath);
  await removeDownloadedVideo(videoPath: finalVideoPath);
}

Future<Directory> getAppDocDirectory() async {
  if (Platform.isIOS) {
    return getApplicationDocumentsDirectory();
  }

  return (await getExternalStorageDirectory())!;
}

Future<void> saveDownloadedVideoToGallery({required String videoPath}) async {
  await ImageGallerySaver.saveFile(videoPath);
}

Future<void> removeDownloadedVideo({required String videoPath}) async {
  try {
    Directory(videoPath).deleteSync(recursive: true);
  } catch (error) {
    debugPrint('$error');
  }
}
