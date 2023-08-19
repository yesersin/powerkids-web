import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class ModelEtkinlikEkleOgrenci {
  ModelOgrenci ogrenci;
  String ogrenciId;
  String tercih;
  bool gelmedi = false;
  bool beklemede = false;
  GroupButtonController controller = GroupButtonController();
  TextEditingController textController = TextEditingController();

  ModelEtkinlikEkleOgrenci(
      {required this.ogrenciId, required this.tercih, required this.ogrenci});
}
