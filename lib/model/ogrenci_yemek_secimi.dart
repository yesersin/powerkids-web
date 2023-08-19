import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';

class ModelOgrenciYemekSecimi {
  String ogrenciId;
  ModelOgrenci ogrenci;
  List<String> yemek;
  List<String> yemekSecili = [];
  bool gelmedi = false;
  bool ozelMenu = false;
  List<String> ozelMenuList = [];

  ModelOgrenciYemekSecimi(
      {required this.ogrenciId, required this.yemek, required this.ogrenci}) {
    yemekSecili = yemek.map((e) => e).toList();
  }

  String yemekDurumu() {
    String durum = "";
    String yemedi = "";
    for (int i = 0; i < yemek.length; i++) {
      if (!yemekSecili.any((element) => element == yemek[i])) {
        yemedi += yemek[i] + ", ";
      }
    }
    for (int i = 0; i < yemekSecili.length; i++) {
      durum += yemekSecili[i] + ", ";
    }
    durum = durum + "yenildi. " + (yemedi.isEmpty ? "" : yemedi + "yenilmedi.");
    if (ozelMenu) {
      return "Özel beslenme programı uygulandı.";
    } else {
      return "Yemekte " + durum;
    }
  }
}
