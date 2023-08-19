import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/radius.dart';
import '../../const/renk.dart';

class Buton {
  Widget mavi(
      {String text = "",
      required VoidCallback? click,
      Color? renk,
      String? image,
      double? height,
      bool? svg}) {
    return Container(
      width: Get.width * 0.6,
      height: height ?? 40,
      decoration: BoxDecoration(
        color: renk ?? Renk.maviAcik,
        borderRadius: BorderRadius.circular(RadiusSabit.buttonRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: MaterialButton(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              resimKoy(image: image, svg: svg),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Renk.beyazMetin,
                    // fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        onPressed: click,
      ),
    );
  }

  Widget resimKoy({String? image, bool? svg}) {
    if (image == null) return SizedBox();
    if (svg != null && svg) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: SvgPicture.asset(image),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Image.asset(image),
      );
    }
    return SizedBox();
  }
}
