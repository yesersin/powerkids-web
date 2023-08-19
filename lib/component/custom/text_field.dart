import 'package:com.powerkidsx/const/radius.dart';
import 'package:flutter/material.dart';

import '../../const/renk.dart';

class Textfield {
  Widget text(
      {String? hint,
      required TextEditingController controller,
      Color? renk,
      Color? textRenk,
      Color? hintRenk,
      int? maxLines,
      int? minLines,
      Widget? suffixIcon,
      required Function? onSubmit(String text)}) {
    return Container(
      decoration: BoxDecoration(
          color: renk ?? Renk.griArkaplan,
          borderRadius: BorderRadius.circular(RadiusSabit.akisTextRadius)),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
// keyboardType: TextInputType.number,
        cursorColor: textRenk ?? Colors.white,
        onSubmitted: onSubmit,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
// textInputAction: TextInputAction.next,
        enableSuggestions: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: InputBorder.none,
// prefixIcon: Icon(
//   Icons.local_phone_outlined,
//   color: Renk.griMetin,
// ),
          suffixIcon: suffixIcon ?? SizedBox(),
          hintText: hint,
          hintStyle: TextStyle(
            color: hintRenk ?? Colors.black54,
          ),
        ),
        style: TextStyle(
          color: textRenk ?? Colors.white,
        ),
        controller: controller,
      ),
    );
  }
}
