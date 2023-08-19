import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/tab/ogretmen_list.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/tab/sohbet_list.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/widget/mesaj_ara.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../controller/ogretmen/c_ogretmen.dart';

late COgretmen c;

List<String> _sayfalar = [];
bool _admin = false;

class VeliMesajGiris extends StatefulWidget {
  const VeliMesajGiris({Key? key}) : super(key: key);

  @override
  State<VeliMesajGiris> createState() => _VeliMesajGirisState();
}

class _VeliMesajGirisState extends State<VeliMesajGiris> {
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
            padding: const EdgeInsets.all(20),
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
    super.initState();
    _sayfalar = ["Sohbet", "Rehber"];
    _admin = false;
    c = Get.find(tag: "cogretmen");
    c.mesajTabController = GroupButtonController(selectedIndex: 0);
    Future.delayed(Duration(milliseconds: 50), () {
      tabDegis(0);
    });
  }

  void tabDegis(int index, {String? ogretmenId}) {
    //öğretmen
    if (!_admin && index == 0) {
      c.mesajSayfa.value = sohbetList(c: c);
    } else if (!_admin && index == 1) {
      c.mesajSayfa.value = ogretmenList(c: c);
    }
  }
}
