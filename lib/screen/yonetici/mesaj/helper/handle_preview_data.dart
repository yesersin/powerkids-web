import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../static/cogretmen.dart';

void handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
  final index = co.messages.indexWhere((element) => element.id == message.id);
  final updatedMessage = (co.messages[index] as types.TextMessage).copyWith(
    previewData: previewData,
  );

  co.messages[index] = updatedMessage;
}
