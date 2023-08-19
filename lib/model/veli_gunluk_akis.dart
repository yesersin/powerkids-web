//velinin günlük akış sayfasında farklı datalar olacağı için bu model oluşturuldu.
class ModelVeliGunlukAkis {
  bool gunlukakis = false;
  bool etkinlikakis = false;
  bool yoklama = false;
  bool dersnot = false;
  dynamic data;
  DateTime tarih;

  ModelVeliGunlukAkis(
      {required this.data,
      bool? yoklama,
      bool? gunlukakis,
      bool? etkinlikakis,
      bool? dersnot,
      required this.tarih}) {
    if (yoklama != null) {
      this.yoklama = true;
    }
    if (gunlukakis != null) {
      this.gunlukakis = true;
    }
    if (etkinlikakis != null) {
      this.etkinlikakis = true;
    }
    if (dersnot != null) {
      this.dersnot = true;
    }
  }
}
