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

class OgretmenDuyuruEkle extends StatefulWidget {
  COgretmen c;

  OgretmenDuyuruEkle({Key? key, required this.c}) : super(key: key);

  @override
  State<OgretmenDuyuruEkle> createState() => _OgretmenDuyuruEkleState();
}

class _OgretmenDuyuruEkleState extends State<OgretmenDuyuruEkle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return GestureDetector(
      onTap: () {
        // SystemChannels.textInput.invokeMethod('TextInput.hide');
        // FocusManager.instance.primaryFocus?.unfocus();
        // FocusScope.of(Get.context!).requestFocus(FocusNode());
        return;
      },
      child: Container(
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
              dosyaSecBtn(c: widget.c, fotograf: true),
              secilenImajlar(c: widget.c, fotograf: true),
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
                        c: widget.c, baslik: _baslik, aciklama: _aciklama, fotograf: true)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
