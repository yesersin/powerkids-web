import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../const/radius.dart';
import '../../../../../model/web_api/ders_program.dart';
import '../../../../../model/web_api/ogretmen_ders_not.dart';
import '../../../../../service/ogretmen_ders_not/ogretmen_ders_not_getir_ders_id.dart';
import '../../../../../static/cprogram.dart';
import 'not_ekle_duzenle_alert.dart';

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
              IconButton(
                  onPressed: () async {
                    Get.context!.loaderOverlay.show();
                    ModelOgretmenDersNot? not = await ogretmenDersNotGetirDersId(
                      sinifId: cp.sinif.id,
                      ay: c.dersProgramSecilenTarih.value.month.toString(),
                      gun: c.dersProgramSecilenTarih.value.day.toString(),
                      yil: c.dersProgramSecilenTarih.value.year.toString(),
                      token: cp.kullanici.token,
                      dersId: ders.id,
                    );
                    c.dersProgramNotEkleSecilenDosyalar.clear();
                    if (not == null) {
                      c.secilenNotBaslik.value = "Ödev";
                      c.secilenNotDurum.value = true;
                      c.notText.text = "";
                    } else {
                      c.secilenNotBaslik.value = not.data.first.baslik;
                      c.secilenNotDurum.value = not.data.first.durum;
                      c.notText.text = not.data.first.not;
                      // not.data.first.dosya = [
                      //   "https://motaen.com/upload/wallpapers/source/2013/01/24/14/01/34501/7k4x872jtq.jpg"
                      // ]; //geçici
                    }
                    Get.context!.loaderOverlay.hide();

                    showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(10),
                            insetPadding: EdgeInsets.symmetric(horizontal: 10),
                            content: notEkleDuzenle(ders: ders, not: not, c: c),
                          );
                        });
                  },
                  icon: Icon(Icons.edit)),
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
