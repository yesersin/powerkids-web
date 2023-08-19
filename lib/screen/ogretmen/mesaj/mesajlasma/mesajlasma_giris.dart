import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/mesajlasma/mesaj_body.dart';
import 'package:com.powerkidsx/screen/ogretmen/mesaj/mesajlasma/widget/baslik.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../model/web_api/mesaj/mesaj_esle_veli_ogretmen.dart';
import '../../../../service/mesaj/mesaj_esle_veli_ogretmen_ekle.dart';
import '../../../../service/mesaj/mesaj_esle_veli_ogretmen_getir.dart';
import '../../../../static/cprogram.dart';

late RecorderController recorder;
late PlayerController playerController;

class OgretmenMesajlasmaGiris extends StatefulWidget {
  COgretmen c;
  String veliId, veliPhoto, adSoyad;

  OgretmenMesajlasmaGiris(
      {Key? key,
      required this.c,
      required this.veliId,
      required this.adSoyad,
      required this.veliPhoto})
      : super(key: key);

  @override
  State<OgretmenMesajlasmaGiris> createState() => _OgretmenMesajlasmaGirisState();
}

class _OgretmenMesajlasmaGirisState extends State<OgretmenMesajlasmaGiris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // FocusManager.instance.primaryFocus?.unfocus();
        },
        child: eslesmeGetir(),
      ),
    );
  }

  Widget eslesmeGetir() {
    return FutureBuilder(
        future: mesajEsleVeliOgretmenGetir(
          veliId: widget.veliId,
          token: cp.kullanici.token,
          ogretmenId: cp.kullanici.data.id,
        ),
        builder: (BuildContext context, AsyncSnapshot<ModelMesajEsleVeliOgretmen?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
            //eşleştirme yok, eşleştirme yap
            debugPrint("eşleştirme yok");
            return eslesmeEkle();
          } else {
            debugPrint("eşleştirme var");
            widget.c.mesajEsleVeliOgretmen = snapshot.data!.data.first;
            return body();
          }
        });
  }

  Widget eslesmeEkle() {
    return FutureBuilder(
        future: mesajEsleVeliOgretmenEkle(
          veliId: widget.veliId,
          token: cp.kullanici.token,
          ogretmenId: cp.kullanici.data.id,
          okulId: cp.okul!.data.id,
          yetki: yetkiText,
        ),
        builder: (BuildContext context,
            AsyncSnapshot<ModelMesajEsleVeliOgretmen?> esleEkleSnapshot) {
          if (esleEkleSnapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          } else if (esleEkleSnapshot.connectionState == ConnectionState.done &&
              esleEkleSnapshot.data != null) {
            debugPrint("eşle ekle yapıldı");
            widget.c.mesajEsleVeliOgretmen = esleEkleSnapshot.data!.data.first;
            return body();
          } else {
            debugPrint("hata1:" + hataMesaj);
            return Text(hataMesaj, style: TextStyle());
          }
        });
  }

  Widget body() {
    widget.c.mesajEsleId = widget.c.mesajEsleVeliOgretmen.id;
    widget.c.mesajVeliId = widget.c.mesajEsleVeliOgretmen.veliId;
    widget.c.mesajGonderenId = cp.kullanici.data.id;
    widget.c.mesajGonderenAd = cp.kullanici.data.adSoyad;
    widget.c.mesajVeliAd = widget.adSoyad;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        baslik(adSoyad: widget.adSoyad, veliPhoto: widget.veliPhoto),
        MesajBody(
          c: widget.c,
        ),
      ],
    );
  }

  @override
  void initState() {
    debugPrint("ad:" + widget.adSoyad);
    debugPrint("veliId:" + widget.veliId);
    super.initState();
    playerController = PlayerController();

    recorder = RecorderController()
      ..updateFrequency = const Duration(milliseconds: 100)
      ..normalizationFactor = defaultTargetPlatform == TargetPlatform.android ? 60 : 40;
  }

  @override
  void dispose() {
    recorder.dispose();

    super.dispose();
    debugPrint("dispose");
  }
}
