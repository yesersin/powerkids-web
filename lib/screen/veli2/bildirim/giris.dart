import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../const/renk.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/bildirim/bildirim.dart';

class BildirimGiris extends StatefulWidget {
  COgretmen c;

  BildirimGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<BildirimGiris> createState() => _BildirimGirisState();
}

class _BildirimGirisState extends State<BildirimGiris> {
  @override
  Widget build(BuildContext context) {
    if (cp.bildirimler == null) {
      return const Center(child: Text("Bildiriminiz yok.", style: TextStyle()));
    }
    return ListView.builder(
      itemCount: cp.bildirimler!.data.length,
      itemBuilder: (BuildContext context, int index) {
        BildirimData data = cp.bildirimler!.data[index];
        String mesaj = "", etkinlikId = "";
        if (cp.bildirimler!.data[index].tip == 1) {
          mesaj = cp.bildirimler!.data[index].mesaj
              .substring(0, cp.bildirimler!.data[index].mesaj.toString().length - 24);
          etkinlikId = cp.bildirimler!.data[index].mesaj
              .substring(cp.bildirimler!.data[index].mesaj.toString().length - 24);
          debugPrint(etkinlikId);
        } else {
          mesaj = cp.bildirimler!.data[index].mesaj;
        }
        return Container(
          margin: EdgeInsets.all(3),
          child: Card(
            child: ListTile(
              leading: _imaj(cp.bildirimler!.data[index].tip),
              title: Column(
                children: [
                  const SizedBox(width: 0, height: 10),
                  Row(
                    children: [
                      Expanded(child: Text(mesaj)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(GetTimeAgo.parse(cp.bildirimler!.data[index].zaman, locale: "tr")
                          .capitalizeFirst!)
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (cp.bildirimler!.data[index].tip == 1 &&
                        cp.bildirimler!.data[index].secenek == "")
                      evetHayirBtn(index: index, etkinlikId: etkinlikId),
                    if (cp.bildirimler!.data[index].tip == 1 &&
                        cp.bildirimler!.data[index].secenek != "")
                      evetHayirSecilmis(
                        secenek: cp.bildirimler!.data[index].secenek,
                      ),
                  ]),
                  const SizedBox(width: 0, height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imaj(int tip) {
    return Image.asset(
      "asset/image/bildirim$tip.png",
      width: 48,
    );
  }

  String mesajText({required BildirimData data}) {
    if (data.tip == 1) {
      if (data.secenek == "") {
        return data.mesaj.substring(0, data.mesaj.toString().length - 24);
      } else {
        return data.mesaj.substring(0, data.mesaj.toString().length - 24) +
            "\n" +
            data.secenek;
      }
    } else {
      return data.mesaj;
    }
  }

  Widget evetHayirBtn({required int index, required String etkinlikId}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () async {},
          child: const Text(
            "Evet",
            style: TextStyle(color: Colors.black),
          )),
      const SizedBox(width: 10, height: 0),
      OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () async {},
          child: const Text("Hayır", style: TextStyle(color: Colors.black))),
    ]);
  }

  Widget evetHayirSecilmis({
    required String secenek,
  }) {
    bool evet = false;
    bool hayir = false;

    if (secenek == "true") {
      evet = true;
    } else if (secenek == "false") {
      hayir = true;
    } else if (secenek == "") {
      evet = false;
      hayir = false;
    }

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (evet)
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Renk.yesil,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  if (evet) {
                    toast(msg: "Daha önce seçim yapılmış!");
                  }
                },
                child: Text("Evet", style: TextStyle(color: Colors.white))),
          SizedBox(width: 10, height: 0),
          if (hayir)
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Renk.yesil,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  if (hayir) {
                    toast(msg: "Daha önce seçim yapılmış!");
                  }
                },
                child: Text("Hayır", style: TextStyle(color: Colors.white))),
        ]);
  }
}
