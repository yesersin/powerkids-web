import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../static/cogretmen.dart';

void addMessage({required types.Message message}) {
  co.messages.insert(0, message);
}
