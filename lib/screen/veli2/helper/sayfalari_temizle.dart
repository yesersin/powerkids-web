import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';

void veliSayfalariTemizle({required COgretmen c}) {
  c.veliSayfalar.clear();
  for (int i = 0; i < c.tempSayfalar.length; i++) {
    c.veliSayfalar.add(c.tempSayfalar[i]);
  }
}
