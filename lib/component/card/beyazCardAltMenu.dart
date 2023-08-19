import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const/renk.dart';

Widget beyazCardAltMenu({
  required COgretmen c,
  String? svgImage,
  required String text,
  Widget? sayfa = null,
  String? svgIcon = null,
  Widget? rightWidget,
  Widget? solWidget,
  Function? komut,
}) {
  return InkWell(
    onTap: () {
      if (komut != null) komut();
      if (sayfa != null) c.ogretmenSayfalar[4] = sayfa;
    },
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (solWidget != null) solWidget,
        if (svgImage != null)
          SvgPicture.asset(
            svgImage,
            height: 24,
          ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: Renk.beyazMetin2,
              fontSize: 16,
            ),
          ),
        ),
        if (sayfa != null) Icon(Icons.keyboard_arrow_right),
        if (rightWidget != null) rightWidget,
        if (svgIcon != null) SvgPicture.asset(svgIcon)
      ],
    ),
  );
}
