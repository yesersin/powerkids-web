import 'package:com.powerkidsx/component/gunluk_akis/button/akis_dosya_sec_btn.dart';
import 'package:com.powerkidsx/component/gunluk_akis/fotograf_gonder_btn.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/gunluk_akis/widget/saat_kutusu.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/gunluk_akis/widget/secilen_imajlar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../component/custom/text_field.dart';

TextEditingController _baslik = TextEditingController();
TextEditingController _aciklama = TextEditingController();

class GunlukAkisYukleEkran extends StatefulWidget {
  COgretmen c;
  bool fotograf;

  GunlukAkisYukleEkran({Key? key, required this.c, required this.fotograf}) : super(key: key);

  @override
  State<GunlukAkisYukleEkran> createState() => _GunlukAkisYukleEkranState();
}

class _GunlukAkisYukleEkranState extends State<GunlukAkisYukleEkran> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _baslik = TextEditingController();
    _aciklama = TextEditingController();
    widget.c.akisSecilenDosyalar.clear();
  }

  @override
  Widget build(BuildContext context) {
    // baslik = TextEditingController();
    // aciklama = TextEditingController();
    return body();
  }

  Widget body() {
    Get.context!.loaderOverlay.hide();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan_kisa.png",
            ),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            dosyaSecBtn(c: widget.c, fotograf: widget.fotograf),
            secilenImajlar(c: widget.c, fotograf: widget.fotograf),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Textfield().text(
                    controller: _baslik,
                    hint: "Başlık",
                    renk: Renk.maviAcik,
                    onSubmit: (text) {},
                  ),
                  const SizedBox(height: 10),
                  Textfield().text(
                    controller: _aciklama,
                    hint: "Açıklama",
                    renk: Renk.turuncu,
                    minLines: 4,
                    maxLines: 6,
                    onSubmit: (text) {},
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // tarihKutusu(c: widget.c),
                      saatKutusu(c: widget.c),
                    ],
                  ),
                  const SizedBox(height: 10),
                  gunlukAkisFotografGonderBtn(
                      c: widget.c,
                      baslik: _baslik,
                      aciklama: _aciklama,
                      fotograf: widget.fotograf)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
