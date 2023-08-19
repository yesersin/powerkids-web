import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../helper/toast.dart';
import '../../../model/web_api/ilac/ilac_update.dart';
import '../../../service/ilac/ilac_update.dart';
import '../../../static/hata_mesaj.dart';

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
      return Center(child: Text("Bildiriminiz yok.", style: TextStyle()));
    }
    return ListView.builder(
      itemCount: cp.bildirimler!.data.length,
      itemBuilder: (BuildContext context, int index) {
        String mesaj = "", etkinlikId = "";
        if (cp.bildirimler!.data[index].tip == 1) {
          debugPrint("x1");
          mesaj = cp.bildirimler!.data[index].mesaj
              .substring(0, cp.bildirimler!.data[index].mesaj.toString().length - 24);
          etkinlikId = cp.bildirimler!.data[index].mesaj
              .substring(cp.bildirimler!.data[index].mesaj.toString().length - 24);
          debugPrint(etkinlikId);
        } else {
          debugPrint("x2");
          mesaj = cp.bildirimler!.data[index].mesaj;
        }
        return Card(
          child: ListTile(
            leading: Icon(CupertinoIcons.alarm),
            title: Column(
              children: [
                SizedBox(width: 0, height: 10),
                Text(mesaj, style: TextStyle()),
                if (cp.bildirimler!.data[index].tip == 1 &&
                    cp.bildirimler!.data[index].secenek == "")
                  evetHayirBtn(index: index, etkinlikId: etkinlikId),
                if (cp.bildirimler!.data[index].tip == 1 &&
                    cp.bildirimler!.data[index].secenek != "")
                  evetHayirSecilmis(
                    secenek: cp.bildirimler!.data[index].secenek,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget evetHayirBtn({required int index, required String etkinlikId}) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      MaterialButton(
          onPressed: () async {
            if (cp.bildirimler!.data[index].secenek != "") {
              toast(msg: "Daha önce seçim yapılmış!");
              return;
            }
            Get.context!.loaderOverlay.show();
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
          child: Text("Evet")),
      MaterialButton(
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
          child: Text("Hayır")),
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
          MaterialButton(
              color: evet ? Colors.green : Colors.grey,
              onPressed: () {
                if (evet) {
                  toast(msg: "Daha önce seçim yapılmış!");
                }
              },
              child: Text("Evet")),
          SizedBox(width: 10, height: 0),
          MaterialButton(
              color: hayir ? Colors.green : Colors.grey,
              onPressed: () {
                if (hayir) {
                  toast(msg: "Daha önce seçim yapılmış!");
                }
              },
              child: Text("Hayır")),
        ]);
  }
}
