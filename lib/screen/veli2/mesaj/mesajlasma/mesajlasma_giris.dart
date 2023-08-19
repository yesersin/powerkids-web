import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/mesajlasma/mesaj_body.dart';
import 'package:com.powerkidsx/screen/veli2/mesaj/mesajlasma/widget/baslik.dart';
import 'package:com.powerkidsx/static/hata_mesaj.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../model/web_api/mesaj/mesaj_esle_veli_ogretmen.dart';
import '../../../../service/mesaj/mesaj_esle_veli_ogretmen_ekle.dart';
import '../../../../service/mesaj/mesaj_esle_veli_ogretmen_getir.dart';
import '../../../../static/cprogram.dart';
import '../../../../static/yetki.dart';

late RecorderController recorder;
late PlayerController playerController;

class VeliMesajlasmaGiris extends StatefulWidget {
  COgretmen c;
  String veliId, veliPhoto, adSoyad;

  VeliMesajlasmaGiris(
      {Key? key,
      required this.c,
      required this.veliId,
      required this.adSoyad,
      required this.veliPhoto})
      : super(key: key);

  @override
  State<VeliMesajlasmaGiris> createState() => _VeliMesajlasmaGirisState();
}

class _VeliMesajlasmaGirisState extends State<VeliMesajlasmaGiris> {
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
          veliId: cp.kullanici.data.id,
          token: cp.kullanici.token,
          ogretmenId: widget.veliId,
        ),
        builder: (BuildContext context, AsyncSnapshot<ModelMesajEsleVeliOgretmen?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
            //eşleştirme yok, eşleştirme yap
            return eslesmeEkle();
          }
          debugPrint("eşleştirme var");
          widget.c.mesajEsleVeliOgretmen = snapshot.data!.data.first;
          return body();
        });
  }

  Widget eslesmeEkle() {
    return FutureBuilder(
        future: mesajEsleVeliOgretmenEkle(
          veliId: cp.kullanici.data.id,
          token: cp.kullanici.token,
          ogretmenId: widget.veliId,
          okulId: cp.okul!.data.id,
          yetki: yetkiText,
        ),
        builder: (BuildContext context,
            AsyncSnapshot<ModelMesajEsleVeliOgretmen?> esleEkleSnapshot) {
          if (esleEkleSnapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          }
          if (esleEkleSnapshot.data == null) {
            return Text(hataMesaj, style: TextStyle());
          }
          debugPrint("eşle ekle yapıldı");
          widget.c.mesajEsleVeliOgretmen = esleEkleSnapshot.data!.data.first;
          return body();
        });
  }

  Widget body() {
    widget.c.mesajEsleId = widget.c.mesajEsleVeliOgretmen.id;
    widget.c.mesajVeliId = widget.c.mesajEsleVeliOgretmen.ogretmenId;
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
