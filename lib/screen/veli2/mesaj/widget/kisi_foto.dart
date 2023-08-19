import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget kisiFoto({String? image}) {
  late Widget i;
  if (image == null) {
    i = ClipRRect(
      borderRadius: BorderRadius.circular(32.0),
      child: Image.asset(
        "asset/image/portre.jpg",
        fit: BoxFit.cover,
        width: 48,
        height: 48,
      ),
    );
  } else {
    i = ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: CachedNetworkImage(
          imageUrl: image,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ));
  }
  return i;
}
