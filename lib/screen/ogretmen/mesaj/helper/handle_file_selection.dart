import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../helper/toast.dart';
import '../../../../static/cogretmen.dart';
import 'mesaj_ekle.dart';

void handleFileSelection() async {
  FilePickerResult? dosya;
  try {
    dosya = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
  } catch (e) {
    toast(msg: "Seçilen dosya okunamadı" + e.toString());
    return;
  }

  if (dosya == null) {
    return;
  }

  int size = dosya.files.first.size;
  var bytes = dosya.files.first.bytes;
  PlatformFile secilenImaj =
      PlatformFile(name: dosya.files.first.name,  size: size,bytes: bytes);
  if (co.mesajText.text.length == 0) co.mesajText.text = "Belge";
  mesajEkle(
      c: co,
      tip: "belge",
      mesajEsleId: co.mesajEsleId,
      type: types.MessageType.file,
      file: secilenImaj,
      mesajGonder: co.mesajText);
}
