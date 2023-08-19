import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';

void sayfalariTemizle({required COgretmen c}) {
  c.yoneticiSayfalar.clear();

  for (int i = 0; i < c.tempSayfalar.length; i++) {
    c.yoneticiSayfalar.add(c.tempSayfalar[i]);
  }
}
