import 'package:flutter/material.dart';

import '../../../../../../const/renk.dart';

Widget telefon({required String telefon}) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.phone,
          color: Renk.beyazMetin2,
        )),
    Text(telefon,
        style: TextStyle(
          color: Renk.beyazMetin2,
        )),
  ]);
}
