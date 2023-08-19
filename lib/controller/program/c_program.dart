import 'package:com.powerkidsx/model/web_api/anket/anket.dart';
import 'package:com.powerkidsx/model/web_api/bildirim/bildirim.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_ayarlar.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_siniflari.dart';
import 'package:com.powerkidsx/screen/ogretmen/anket/model/model_anket_text_controller.dart';
import 'package:get/get.dart';

import '../../model/web_api/besadim.dart';
import '../../model/web_api/kullanici/kullanici_giris.dart';
import '../../model/web_api/ogrenci/ogrenci_sayisi.dart';
import '../../model/web_api/okul/okul.dart';

//programla ilgili genel datanın tutulduğu controller
class CProgram extends GetxController {
  late ModelBesadim besadim;
  late ModelKullanici kullanici;

  List<ModelOkul> okulList = [];
  List<ModelOkulAyarlar> okulAyarlarList = [];
  ModelOkul? okul = null;
  late ModelOkulAyarlar okulAyarlar;
  late ModelOkulSiniflari siniflar;
  late ModelSinif sinif;

  late ModelBildirim? bildirimler;
  var bildirimSayisi = 0.obs;

  late ModelAnket? anket;
  List<ModelAnketTextController> anketController = [];

  String dil = ""; //seçilen dil text

  late ModelOgrenciSayisi? ogrenciSayisi; //okulun toplam öğrenci sayısı
}
