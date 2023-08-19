import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/screen/yonetici/mesaj/tab/ogretmen_list.dart';
import 'package:com.powerkidsx/screen/yonetici/mesaj/tab/sohbet_list.dart';
import 'package:com.powerkidsx/screen/yonetici/mesaj/widget/mesaj_ara.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../static/cogretmen.dart';
import '../../../static/cprogram.dart';

List<String> _sayfalar = [];
bool _admin = true;

class YoneticiMesajGiris extends StatefulWidget {
  const YoneticiMesajGiris({Key? key}) : super(key: key);

  @override
  State<YoneticiMesajGiris> createState() => _YoneticiMesajGirisState();
}

class _YoneticiMesajGirisState extends State<YoneticiMesajGiris> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Renk.turuncu,
            ),
            child: araContainer(c: co),
          ),
          GroupButton(
            controller: co.mesajTabController,
            buttons: _sayfalar,
            onSelected: (text, index, value) {
              tabDegis(index);
            },
          ),
          Obx(() => Expanded(child: co.mesajSayfa.value))
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cp.kullanici.data.yetki.admin = Random().nextBool(); //geçici
    debugPrint("admin:" + cp.kullanici.data.yetki.admin.toString());
    _sayfalar = ["Öğretmen", "Sohbet"];
    _admin = true;
    co.mesajTabController = GroupButtonController(selectedIndex: _admin ? 0 : 1);
    Future.delayed(const Duration(milliseconds: 50), () {
      tabDegis(0);
    });
  }

  void tabDegis(int index, {String? ogretmenId}) {
    if (_admin && index == 1 && ogretmenId == null) {
      toast(msg: "Listeden öğretmen seçiniz.");
      return;
    }

    //admin
    if (_admin && index == 0) {
      debugPrint("1");
      co.mesajSayfa.value = ogretmenList(c: co);
    } else if (_admin && index == 1) {
      debugPrint("2");
      co.mesajSayfa.value = sohbetList(c: co);
    }
  }
}
