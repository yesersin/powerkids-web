import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';

import '../../../../../const/renk.dart';
import '../../../../../model/web_api/ders_program.dart';
import '../../../../../static/cprogram.dart';
import 'ders.dart';

Widget dersProgramList({required ModelDersProgram program, required COgretmen c}) {
  int dersSiraNo = 0;
  return Column(
    children: [
      ListView.builder(
        padding: EdgeInsets.only(bottom: 60),
        shrinkWrap: true,
        primary: false,
        itemCount: program.data.length,
        itemBuilder: (BuildContext context, int index) {
          if (cp.okulAyarlar.data.dersProgrami == "haftalik") {
            if (program.data[index].gun == (c.haftalikBtnController.selectedIndex! + 1)) {
              dersSiraNo++;
              return ders(
                renk: Renk.renkList[index % Renk.renkList.length],
                sayi: dersSiraNo,
                // sayi: index + 1,
                dersAdi: program.data[index].baslik,
                ders: program.data[index],
                dersAciklama: program.data[index].icerik * 500,
                c: c,
              );
            } else {
              return SizedBox(width: 0, height: 0);
            }
          }
          dersSiraNo++;
          return ders(
            renk: Renk.renkList[index % Renk.renkList.length],
            sayi: dersSiraNo,
            dersAdi: program.data[index].baslik,
            ders: program.data[index],
            dersAciklama: program.data[index].icerik * 500,
            c: c,
          );
        },
      ),
    ],
  );
}
