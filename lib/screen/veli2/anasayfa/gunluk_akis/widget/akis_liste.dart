import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/url_ac.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis.dart';
import 'package:com.powerkidsx/model/web_api/ogretmen_ders_not.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../component/card/etkinlik_card.dart';
import '../../../../../component/card/yoklamaCard.dart';
import '../../../../../component/gunluk_akis/akis_fotograf_album.dart';
import '../../../../../component/gunluk_akis/button/akis_aciklama_btn.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/tarih.dart';
import '../../../../../helper/toast.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_etklnlik_gecmis.dart';
import '../../../../../model/web_api/ogrenci/ogrenci_yoklama_gecmis.dart';
import '../../../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../ogretmen/anasayfa/gunluk_akis/widget/akis_video.dart';

Widget veliAkisListWidget({required COgretmen c}) {
  return Obx(
    () => ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: c.veliAkisList.length,
        itemBuilder: (context, index) {
          if (c.veliAkisList[index].gunlukakis) {
            return _gunlukAkis(akis: c.veliAkisList[index].data as GunlukAkisData);
          }
          if (c.veliAkisList[index].yoklama) {
            OgrenciYoklamaGecmis data = c.veliAkisList[index].data as OgrenciYoklamaGecmis;
            return yoklamaCard(
              saat: Tarih().saatDk(data.zaman),
              mesaj: data.mesaj,
              yoklamaDurum: data.yoklamaDurum,
              renk: Renk.numaraliRenk(index),
            );
          }
          if (c.veliAkisList[index].dersnot) {
            OgretmenDersNot data = c.veliAkisList[index].data as OgretmenDersNot;

            return GestureDetector(
              onTap: () {
                if (data.dosya.isNotEmpty) {
                  urlAc(url: data.dosya.first);
                }
              },
              child: yoklamaCard(
                saat: Tarih().saatDk(data.createdAt),
                mesaj: data.baslik + "\n" + data.not * 1,
                yoklamaDurum: "", //yoklamacardla aynı olduğu için boş kalmalı
                renk: Renk.numaraliRenk(index),
              ),
            );
          }
          if (c.veliAkisList[index].etkinlikakis) {
            OgrenciEtkinlikGecmis data = c.veliAkisList[index].data as OgrenciEtkinlikGecmis;

            return etkinlikCard(
              saat: Tarih().saatDk(data.zaman),
              baslik: data.etkinlikAdi,
              mesaj: data.tercih,
              ogretmenAd: data.ogretmenAdi,
              renk: Renk.numaraliRenk(index),
            );
          }
          return SizedBox(width: 0, height: 0);
        }),
  );
}

Widget _gunlukAkis({required GunlukAkisData akis}) {
  Get.context!.loaderOverlay.hide();
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration:
              BoxDecoration(color: Renk.turuncu, borderRadius: BorderRadius.circular(18)),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(width: 10, height: 0),
            Text(
                ((Tarih().saatDkSn(akis.tarihSaat))
                    .substring(0, (Tarih().saatDkSn(akis.tarihSaat).length - 3))),
                style: TextStyle(fontSize: 12, color: Renk.beyazMetin)),
            const Divider(thickness: 3, color: Colors.white, height: 10),
            Expanded(
                child: Text(akis.baslik,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Renk.beyazMetin))),
            Align(
                alignment: Alignment.centerRight, child: akisAciklamaBtn(akis, Get.context!)),
          ]),
        ),
        const SizedBox(width: 0, height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: akis.tip == 1
              ? fotograflar(url: akis.url, c: co, etkinlikId: akis.id)
              : akisVideo(url: akis.url, etkinlikId: akis.id),
        ),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // akisBegenenlerBtn(akis),
              InkWell(
                onTap: () async {
                  Get.context!.loaderOverlay.show();
                  String? sonuc = await updateBegenGorulduGunlukAkis(
                      token: cp.kullanici.token,
                      body: {"begendi": cp.kullanici.data.adSoyad},
                      id: akis.id);
                  toast(msg: sonuc.toString());
                  Get.context!.loaderOverlay.hide();
                },
                child: SvgPicture.asset(
                  "asset/image/kalp.svg",
                ),
              ),
            ]),
        const SizedBox(width: 0, height: 10),
      ]),
    ),
  );
}
