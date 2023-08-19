import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

import '../../../../helper/toast.dart';
import '../../../../static/cogretmen.dart';
import 'mesaj_ekle.dart';

void handleImageSelection() async {
  late XFile? image;
  try {
    image = await ImagePicker().pickImage(imageQuality: 70, source: ImageSource.gallery);
  } catch (e) {
    toast(msg: "Seçilen dosya imaj değil:" + e.toString());
    return;
  }

  if (image == null) {
    return;
  }
  int size = await image.length();
  var bytes=await image.readAsBytes();
  PlatformFile secilenImaj = PlatformFile(
    name: image.name,
    bytes: bytes,
    size: size,
  );
  if (co.mesajText.text.length == 0) co.mesajText.text = "Fotoğraf";
  mesajEkle(
      c: co,
      tip: "foto",
      mesajEsleId: co.mesajEsleId,
      type: types.MessageType.image,
      file: secilenImaj,
      mesajGonder: co.mesajText);
}
