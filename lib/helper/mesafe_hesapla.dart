import 'package:latlong2/latlong.dart';

double mesafeHesapla(
    {required num lat1, required num lon1, required num lat2, required num lon2}) {
  LatLng f = LatLng(lat1.toDouble(), lon1.toDouble());
  LatLng s = LatLng(lat2.toDouble(), lon2.toDouble());
  final Distance distance = Distance();
  final meter = distance(f, s);
  return meter;
  //metre olarak hesaplar
}
