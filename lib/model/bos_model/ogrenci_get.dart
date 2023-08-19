import 'package:com.powerkidsx/model/web_api/ogrenci/ogrenci_get.dart';

ModelOgrenciGet bosGetOgrenci() {
  return ModelOgrenciGet(
      success: 0,
      data: OgrenciGetData(
        id: "",
        okulId: "okulId",
        arsiv: false,
        kimlikNo: "kimlikNo",
        cinsiyet: "cinsiyet",
        adSoyad: "adSoyad",
        dogumTarihi: DateTime.now(),
        servis: 0,
        fotografUrl: "fotografUrl",
        sinifId: "sinifId",
        ozelBeslenme: true,
        ozelNot: "ozelNot",
        onkayitMi: true,
        durum: true,
        onkayitTarihi: DateTime.now(),
        kayitZamani: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      ));
}
