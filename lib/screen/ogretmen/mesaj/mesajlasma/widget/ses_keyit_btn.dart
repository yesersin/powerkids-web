import 'package:flutter/material.dart';

import '../../helper/handle_audio_selection.dart';

late String sesDosyasi;

IconButton sesKayitBtn() {
  return IconButton(
    icon: Icon(
      Icons.mic,
      color: Colors.black,
    ),
    onPressed: () async {
      handleAudioSelection();
    },
  );
}
