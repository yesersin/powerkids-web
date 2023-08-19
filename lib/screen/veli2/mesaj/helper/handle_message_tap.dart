import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../helper/url_ac.dart';

void handleMessageTap(BuildContext _, types.Message message) async {
  if (message.type == types.MessageType.file) {
    var m = message as types.FileMessage;
    urlAc(url: m.uri);
  }
}
