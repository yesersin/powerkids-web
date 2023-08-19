import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../component/custom/text_field.dart';
import '../../../../../const/renk.dart';
import '../../../../../helper/url_ac.dart';
import '../../../../../model/web_api/ders_program.dart';
import '../../../../../model/web_api/ogretmen_ders_not.dart';
import '../helper/ders_program_dosya_sec_click.dart';
import 'guncelle_btn.dart';
import 'not_ekle_btn.dart';

Widget notEkleDuzenle(
    {required DersProgram ders, ModelOgretmenDersNot? not, required COgretmen c}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(width: Get.width, height: 0),
        Obx(
          () => DropdownButton(
              items: c.secilenNotBaslikList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              value: c.secilenNotBaslik.value,
              onChanged: (value) {
                if (not == null) c.secilenNotBaslik.value = value.toString();
                // debugPrint(value.toString());
              }),
        ),
        Textfield().text(
          controller: c.notText,
          textRenk: Colors.black,
          minLines: 5,
          maxLines: 10,
          hint: "Lütfen not yazınız.",
          onSubmit: (text) {},
        ),
        if (not != null && not.data.first.dosya.isNotEmpty)
          GestureDetector(
            onTap: () {},
            child: MaterialButton(
                onPressed: () {
                  urlAc(url: not.data.first.dosya.first.toString());
                },
                child: Text("Ek Dosya", style: TextStyle())),
          ),
        if (not != null)
          Obx(
            () => Switch.adaptive(
                value: c.secilenNotDurum.value,
                onChanged: (value) {
                  c.secilenNotDurum.value = value;
                }),
          ),
        if (not == null)
          Container(
            padding: EdgeInsets.all(3),
            decoration:
                BoxDecoration(color: Renk.kirmizi, borderRadius: BorderRadius.circular(32)),
            child: Obx(
              () => c.dersProgramNotEkleSecilenDosyalar.isEmpty
                  ? InkWell(
                      onTap: () {
                        dersProgramDosyaSecClick(
                          c: c,
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.attach_file, color: Colors.white),
                          Text("Dosya Ekle", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                  : Row(children: [
                      Text(
                          c.dersProgramNotEkleSecilenDosyalar.length.toString() +
                              " dosya seçildi.",
                          style: TextStyle(color: Colors.white)),
                      IconButton(
                          onPressed: () {
                            c.dersProgramNotEkleSecilenDosyalar.clear();
                          },
                          icon: Icon(Icons.delete, color: Colors.white)),
                    ]),
            ),
          ),
        if (not != null) notGuncelleBtn(not: not, c: c),
        if (not == null) notEkleBtn(ders: ders, c: c)
      ],
    ),
  );
}
