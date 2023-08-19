import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../static/cogretmen.dart';
import 'add_message.dart';

void handleSendPressed(types.PartialText message) {
  final textMessage = types.TextMessage(
    author: co.mesajGonderen,
    createdAt: DateTime.now().millisecondsSinceEpoch,
    id: "1",
    text: message.text,
  );

  addMessage(message: textMessage);
}
