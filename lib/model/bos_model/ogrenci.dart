import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';

ModelOgrenci bosOgrenci() {
  return ModelOgrenci(
      id: "id",
      okulId: "okulId",
      arsiv: false,
      kimlikNo: "kimlikNo",
      cinsiyet: "cinsiyet",
      adSoyad: "adSoyad",
      dogumTarihi: DateTime.now(),
      servis: 0,
      fotografUrl: "fotografUrl",
      sinifId: "sinifId",
      ozelBeslenme: false,
      ozelNot: "ozelNot",
      onkayitMi: false,
      durum: true,
      onkayitTarihi: DateTime.now(),
      kayitZamani: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0);
}
