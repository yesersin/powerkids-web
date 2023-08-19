import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../const/radius.dart';
import '../../../../../model/web_api/ders_program.dart';
import '../../../../../model/web_api/ogretmen_ders_not.dart';
import '../../../../../service/ogretmen_ders_not/ogretmen_ders_not_getir_ders_id.dart';
import '../../../../../service/ogretmen_ders_not/ogretmen_ders_not_update_body.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/hata_mesaj.dart';

Widget ders(
    {required DersProgram ders,
    Color? renk,
    required int sayi,
    required String dersAdi,
    required String dersAciklama,
    required COgretmen c}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(RadiusSabit.dersRadius),
      boxShadow: [
        BoxShadow(
          color: Color(0x3f000000),
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
      color: renk ?? Colors.white,
    ),
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: EdgeInsets.all(5),
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dersAdi,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (cp.kullanici.data.yetki.brans)
                    Text(ders.sinifAdi.first,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                ],
              ),
              Spacer(),
              FutureBuilder(
                future: ogretmenDersNotGetirDersId(
                  sinifId: cp.sinif.id,
                  ay: c.dersProgramSecilenTarih.value.month.toString(),
                  gun: c.dersProgramSecilenTarih.value.day.toString(),
                  yil: c.dersProgramSecilenTarih.value.year.toString(),
                  token: cp.kullanici.token,
                  dersId: ders.id,
                ),
                builder:
                    (BuildContext context, AsyncSnapshot<ModelOgretmenDersNot?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(width: 0, height: 0);
                  }
                  if (snapshot.data == null) {
                    return SizedBox(width: 0, height: 0);
                  }
                  return infoBtn(
                      dersNot: snapshot.data!, renk: renk ?? Colors.lightBlueAccent);
                },
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.1,
            child: SingleChildScrollView(
              child: Text(
                dersAciklama,
                maxLines: 60,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
      leading: Text(
        ((sayi < 10) ? "0" : "") + sayi.toString(),
        style: TextStyle(
          color: Color(0xb2ffffff),
          fontSize: 48,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget infoBtn({required ModelOgretmenDersNot dersNot, required Color renk}) {
  OgretmenDersNot not = dersNot.data.first;
  return IconButton(
      onPressed: () async {
        Map<String, String> body = {};
        //:_id:not id, goruldu:veliId
        body.addAll({"_id": not.id});
        body.addAll({"goruldu": cp.kullanici.data.id});
        String? update = await ogretmenDersNotUpdateBody(
          body: body,
          token: cp.kullanici.token,
        );

        if (update == null) {
          debugPrint("not update:" + hataMesaj);
        } else {
          debugPrint("İşlem tamamlandı.");
        }
        Pencere().ac(
          content: Container(
            width: Get.width * 0.8,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: renk,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(not.not, style: TextStyle(color: Colors.white)),
                  SizedBox(width: 0, height: 10),
                  not.dosya.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            urlAc(url: not.dosya.first.toString());
                          },
                          child: Text("Dosya", style: TextStyle(color: Colors.white)),
                        )
                      : SizedBox(width: 0, height: 0),
                  SizedBox(width: 0, height: 10),
                  Row(children: [
                    Text("Öğretmen:" + not.ogretmenAdSoyad,
                        style: TextStyle(color: Colors.white)),
                  ]),
                ],
              ),
            ),
          ),
          context: Get.context!,
          baslik: not.baslik,
        );
      },
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
      ));
}
