import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../static/cogretmen.dart';

types.Message mesajOlustur({
  required types.MessageType type,
  required String id,
  required types.User u,
  required String mesaj,
  required String media,
}) {
  late types.Message message;
  if (type == types.MessageType.text) {
    message = (types.TextMessage(
      id: id,
      author: u,
      text: mesaj,
      showStatus: true,
      status: types.Status.seen,
    ));
  } else if (type == types.MessageType.image) {
    message = (types.ImageMessage(
      id: id,
      author: co.mesajGonderen,
      uri: media,
      size: 200,
      name: "foto",
      showStatus: true,
      status: types.Status.seen,
    ));
  } else if (type == types.MessageType.video) {
    message = (types.VideoMessage(
      id: id,
      author: u,
      uri: media,
      size: 200,
      name: id,
      showStatus: true,
      status: types.Status.seen,
    ));
  } else if (type == types.MessageType.file) {
    message = (types.FileMessage(
      id: id,
      author: u,
      uri: media,
      size: 200,
      name: "Dosya",
      showStatus: true,
      status: types.Status.seen,
    ));
  } else if (type == types.MessageType.audio) {
    message = (types.AudioMessage(
      duration: Duration(seconds: 60),
      id: id,
      author: u,
      uri: media,
      size: 200,
      name: "Dosya",
      showStatus: true,
      status: types.Status.seen,
    ));
  }
  return message;
}
