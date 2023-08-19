import 'package:com.powerkidsx/screen/veli2/mesaj/helper/mesaj_ekle.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/mesajlasma/widget/ses_keyit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_svg/svg.dart';

import '../../../../../component/custom/text_field.dart';
import '../../../../../const/renk.dart';
import '../../../../../static/cogretmen.dart';
import '../../helper/handle_file_selection.dart';
import '../../helper/handle_image_selection.dart';
import '../../helper/handle_video_selection.dart';

Container mesajFooter({required TextEditingController mesajGonder}) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Textfield().text(
              onSubmit: (text) {
                mesajEkle(
                    c: co,
                    tip: "text",
                    mesajEsleId: co.mesajEsleId,
                    type: types.MessageType.text,
                    mesajGonder: mesajGonder);
              },
              controller: mesajGonder,
              hint: "Mesaj",
              textRenk: Renk.beyazMetin2,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      handleFileSelection();
                    },
                    child: SvgPicture.asset(
                      "asset/image/mesaj_ekle.svg",
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      handleVideoSelection();
                    },
                    child: Icon(Icons.video_call),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      handleImageSelection();
                    },
                    child: SvgPicture.asset(
                      "asset/image/mesaj_kamera.svg",
                    ),
                  ),
                  sesKayitBtn()
                ],
              )),
        ),
        // SizedBox(width: 5),
        // Container(
        //   decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       gradient: LinearGradient(colors: [Renk.turuncuAcik, Renk.turuncu], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        //   child: sesKayitBtn(),
        // )
      ],
    ),
  );
}
