class ModelMesajSohbet {
  String adSoyad;
  String sonMesaj;
  String id;
  String profilResim;
  String notificationId;
  String okunmayan;
  DateTime guncelleme;

  ModelMesajSohbet({
    required this.adSoyad,
    required this.sonMesaj,
    required this.id,
    required this.profilResim,
    required this.notificationId,
    required this.guncelleme,
    required this.okunmayan,
  });
}
