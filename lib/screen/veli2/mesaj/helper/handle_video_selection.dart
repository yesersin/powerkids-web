import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

import '../../../../helper/toast.dart';
import '../../../../static/cogretmen.dart';
import 'mesaj_ekle.dart';

void handleVideoSelection() async {
  late XFile? video;
  try {
    video = await ImagePicker().pickVideo(source: ImageSource.gallery);
  } catch (e) {
    toast(msg: "Seçilen dosya video değil:" + e.toString());
    return;
  }

  if (video == null) {
    return;
  }
  int size = await video.length();
  PlatformFile secilenImaj = PlatformFile(name: video.name, path: video.path, size: size);
  if (co.mesajText.text.length == 0) co.mesajText.text = "Video";
  mesajEkle(
      c: co,
      tip: "video",
      mesajEsleId: co.mesajEsleId,
      type: types.MessageType.video,
      file: secilenImaj,
      mesajGonder: co.mesajText);
}
