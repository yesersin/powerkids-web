import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/tab/ogretmen_list.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/tab/rehber_list.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/tab/sohbet_list.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/widget/mesaj_ara.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../controller/ogretmen/c_ogretmen.dart';

late COgretmen c;

List<String> _sayfalar = [];
bool _admin = false;

class OgretmenMesajGiris extends StatefulWidget {
  const OgretmenMesajGiris({Key? key}) : super(key: key);

  @override
  State<OgretmenMesajGiris> createState() => _OgretmenMesajGirisState();
}

class _OgretmenMesajGirisState extends State<OgretmenMesajGiris> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Renk.turuncu,
            ),
            child: araContainer(c: c),
          ),
          GroupButton(
            controller: c.mesajTabController,
            buttons: _sayfalar,
            onSelected: (text, index, value) {
              tabDegis(index);
            },
          ),
          Obx(() => Expanded(child: c.mesajSayfa.value))
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sayfalar = ["Sohbet", "Rehber", "Öğretmen"];
    _admin = false;
    c = Get.find(tag: "cogretmen");
    c.mesajTabController = GroupButtonController(selectedIndex: _admin ? 0 : 1);
    Future.delayed(const Duration(milliseconds: 20), () {
      if (_admin) {
        tabDegis(0);
      } else {
        tabDegis(1);
      }
    });
  }

  void tabDegis(int index, {String? ogretmenId}) {
    //öğretmen
    if (!_admin && index == 0) {
      c.mesajSayfa.value = sohbetList(c: c);
    } else if (!_admin && index == 1) {
      c.mesajSayfa.value = rehberList(c: c);
    } else if (!_admin && index == 2) {
      c.mesajSayfa.value = ogretmenList(c: c);
    }

    if (_admin && index == 1 && ogretmenId == null) {
      toast(msg: "Listeden öğretmen seçiniz.");
      return;
    }

    //admin
    if (_admin && index == 0) {
      c.mesajSayfa.value = ogretmenList(c: c);
    } else if (_admin && index == 1) {
      c.mesajSayfa.value = sohbetList(c: c);
    }
  }
}
