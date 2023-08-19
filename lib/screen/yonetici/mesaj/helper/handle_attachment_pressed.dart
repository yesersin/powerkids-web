import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'handle_file_selection.dart';
import 'handle_image_selection.dart';

void handleAtachmentPressed() {
  showModalBottomSheet<void>(
    context: Get.context!,
    builder: (BuildContext context) => SafeArea(
      child: SizedBox(
        height: 144,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                handleImageSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Photo'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                handleFileSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('File'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
