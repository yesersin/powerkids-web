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
  PlatformFile secilenImaj =
      PlatformFile(name: dosya.files.first.name, path: dosya.files.first.path, size: size);
  if (co.mesajText.text.length == 0) co.mesajText.text = "Belge";
  mesajEkle(
      c: co,
      tip: "belge",
      mesajEsleId: co.mesajEsleId,
      type: types.MessageType.file,
      file: secilenImaj,
      mesajGonder: co.mesajText);
}

// void handleFileSelection() async {
//   final result = await FilePicker.platform.pickFiles(
//     type: FileType.any,
//   );
//
//   if (result != null && result.files.single.path != null) {
//     final message = types.FileMessage(
//       author: co.mesajGonderen,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: "1",
//       name: result.files.single.name,
//       size: result.files.single.size,
//       uri: result.files.single.path!,
//     );
//
//     addMessage(message: message);
//   }
// }
