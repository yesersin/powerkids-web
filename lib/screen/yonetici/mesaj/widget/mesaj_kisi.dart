import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../const/renk.dart';
import '../mesajlasma/mesajlasma_giris.dart';
import '../tab/sohbet_list.dart';
import 'kisi_foto.dart';

Widget mesajKisi({
  required String profilImaj,
  required String adSoyad,
  required String sonMesaj,
  String? saat,
  String? bildirim,
  required String veliId,
  required COgretmen c,
  bool? ogretmenList,
}) {
  return InkWell(
    onTap: () {
      debugPrint("click");
      debugPrint(adSoyad);
      debugPrint(veliId);
      if (ogretmenList != null && ogretmenList) {
        c.mesajAdminTiklananOgretmen.value = veliId;
        c.mesajSayfa.value = sohbetList(c: c, ogretmenId: veliId);
        c.mesajTabController.selectIndex(1);
        return;
      }
      Get.to(
        () => OgretmenMesajlasmaGiris(
          c: c,
          veliId: veliId,
          adSoyad: adSoyad,
          veliPhoto: profilImaj,
        ),
      );
    },
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: kisiFoto(image: profilImaj),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            adSoyad,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            overflow: TextOverflow.ellipsis,
            sonMesaj,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          )
        ],
      ),
      trailing: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (saat != null) Text(saat),
            if (bildirim != null)
              Container(
                decoration: BoxDecoration(color: Renk.yesilBildirim, shape: BoxShape.circle),
                width: 24,
                height: 24,
                child: Center(
                  child: Text(
                    bildirim,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    ),
  );
}
