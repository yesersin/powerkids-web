import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget ogrenciProfilFoto({required String url}) {
  return Container(
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    width: 150,
    height: 150,
    // color: Colors.red,
    child: Center(
      child: Stack(
        children: [
          CircleAvatar(
            foregroundImage: CachedNetworkImageProvider(url),
            radius: 150,
          ),
        ],
      ),
    ),
  );
}
