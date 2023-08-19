import 'package:com.powerkidsx/helper/telefon_ara.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/renk.dart';
import '../../widget/kisi_foto.dart';

Widget kisi({
  String? image,
  required String adSoyad,
}) {
  return InkWell(
    child: ListTile(
      tileColor: Colors.yellow,
      contentPadding: const EdgeInsets.only(top: 20, left: 0, right: 0),
      leading: Wrap(
        children: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
          kisiFoto(image: image),
        ],
      ),
      // leading: kisiFoto(image: image),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            adSoyad,
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Row(
            children: [
              Text(
                adSoyad,
                maxLines: 1,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Icon(
                Icons.circle,
                size: 12,
                color: Renk.yesilBildirim,
              )
            ],
          ),
        ],
      ),
      trailing: Container(
          margin: EdgeInsets.only(top: 10),
          child: IconButton(
            icon: Icon(Icons.phone_outlined),
            onPressed: () {
              telefonAra(cp.okul!.data.telefon);
            },
            color: Colors.white,
          )),
    ),
  );
}
