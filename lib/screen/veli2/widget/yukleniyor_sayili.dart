import 'package:flutter/material.dart';

Widget yukleniyorSayili(int yuklenen, int toplam) {
  return Center(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 0, height: 10),
            Text(
              yuklenen.toString() +
                  "/" +
                  toplam.toString() +
                  "\n Yüklemi işlemi devam ediyor.\nLütfen bekleyin.",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    ),
  );
}
