import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../const/renk.dart';
import '../../../helper/toast.dart';
import '../../../model/web_api/ilac/ilac_update.dart';
import '../../../service/ilac/ilac_update.dart';
import '../../../static/hata_mesaj.dart';

class OgretmenBildirimGiris extends StatefulWidget {
  COgretmen c;

  OgretmenBildirimGiris({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenBildirimGiris> createState() => _OgretmenBildirimGirisState();
}

class _OgretmenBildirimGirisState extends State<OgretmenBildirimGiris> {
  @override
  Widget build(BuildContext context) {
    if (cp.bildirimler == null) {
      return const Center(child: Text("Bildiriminiz yok.", style: TextStyle()));
    }
    return ListView.builder(
      itemCount: cp.bildirimler!.data.length,
      itemBuilder: (BuildContext context, int index) {
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
                      Text(
                        GetTimeAgo.parse(cp.bildirimler!.data[index].zaman,
                                locale: "tr", pattern: "dd/MM/yyyy hh:mm")
                            .capitalizeFirst!,
                        style: TextStyle(fontSize: 10),
                      )
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
                  SizedBox(width: 0, height: 10),
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

  Widget evetHayirBtn({required int index, required String etkinlikId}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onPressed: () async {
            debugPrint("xx1");
            if (cp.bildirimler!.data[index].secenek != "") {
              toast(msg: "Daha önce seçim yapılmış!");
              // return;
            }
            debugPrint("xx2");
            Get.context!.loaderOverlay.show();
            debugPrint("etkinlikid:" + etkinlikId);
            ModelIlacUpdate? cevap = await ilacUpdate(
              token: cp.kullanici.token,
              body: {"_id": etkinlikId, "secenek": "true"},
            );
            if (cevap == null) {
              toast(msg: hataMesaj);
            } else {
              cp.bildirimler!.data[index].secenek = cevap.data.secenek;
            }
            Get.context!.loaderOverlay.hide();
          },
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
          onPressed: () async {
            if (cp.bildirimler!.data[index].secenek != "") {
              toast(msg: "Daha önce seçim yapılmış!");
              return;
            }
            Get.context!.loaderOverlay.show();
            ModelIlacUpdate? cevap = await ilacUpdate(
              token: cp.kullanici.token,
              body: {"_id": etkinlikId, "secenek": "false"},
            );
            if (cevap == null) {
              toast(msg: hataMesaj);
            } else {
              cp.bildirimler!.data[index].secenek = cevap.data.secenek;
            }
            Get.context!.loaderOverlay.hide();
          },
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
