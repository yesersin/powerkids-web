import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/gunluk_akis/widget/akis_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/tarih.dart';
import '../../static/cprogram.dart';
import 'akis_fotograf_album.dart';
import 'button/akis_aciklama_btn.dart';
import 'button/akis_begenenler_btn.dart';
import 'button/akis_duzenle_btn.dart';
import 'button/akis_goruldu_btn.dart';
import 'button/akis_onay_btn.dart';
import 'button/akis_sil_btn.dart';

Widget akisListWidget({required COgretmen c}) {
  return Obx(
    () => ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: c.akis.length,
        itemBuilder: (context, index) {
          if (c.akis[index].durum == false) {
            return const SizedBox(width: 0, height: 0);
          } else if (cp.kullanici.data.yetki.admin) {
            //adminse hepsini göster
          } else if (c.akis[index].ekleyenId != cp.kullanici.data.id &&
              cp.kullanici.data.yetki.brans) {
            //branş öğretmenine kendi paylaşımlarını göster
            return const SizedBox(width: 0, height: 0);
          }

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Renk.turuncu,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                    const SizedBox(width: 10, height: 0),
                    Text(
                        ((Tarih().saatDkSn(c.akis[index].tarihSaat)).substring(
                            0, (Tarih().saatDkSn(c.akis[index].tarihSaat).length - 3))),
                        style: TextStyle(fontSize: 12, color: Renk.beyazMetin)),
                    const Divider(thickness: 3, color: Colors.white, height: 10),
                    Expanded(
                        child: Text(c.akis[index].baslik,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: akisAciklamaBtn(c.akis[index], context),
                    ),
                  ]),
                ),
                const SizedBox(width: 0, height: 10),
                Container(
                  height: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: c.akis[index].tip == 1
                        ? fotograflar(
                            url: c.akis[index].url, c: c, etkinlikId: c.akis[index].id)
                        : akisVideo(url: c.akis[index].url, etkinlikId: c.akis[index].id),
                  ),
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      akisBegenenlerBtn(c.akis[index]),
                      akisGorulduBtn(c.akis[index]),
                      akisOnayBtn(index: index, akis: c.akis[index], c: c),
                      akisDuzenleBtn(index: index, akis: c.akis[index], c: c),
                      akisSilBtn(index: index, akis: c.akis[index], c: c),
                    ]),
              ]),
            ),
          );
        }),
  );
}
