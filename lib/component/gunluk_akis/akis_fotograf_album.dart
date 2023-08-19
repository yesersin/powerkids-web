import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../helper/image_kaydet.dart';
import '../../helper/izin.dart';
import '../../helper/url_ac.dart';

Widget fotoAlbum({required List<String> url, required COgretmen c}) {
  List<Widget> fotoList = [];
  for (int i = 0; i < url.length; i++) {
    fotoList.add(GestureDetector(
      onLongPress: () {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                width: Get.width * 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          bool izin = false;
                          await Izin().dosyalar(context).then((value) {
                            izin = value;
                            print("Dosya izni:$izin");
                            imageKaydet(url[i]);
                            toast(msg: "Fotoğraf kaydedildi.");
                            Get.back();
                          });
                          if (izin == false) return;
                        },
                        child: Text("Fotoğrafı İndir")),
                    OutlinedButton(
                        onPressed: () async {
                          bool izin = false;
                          await Izin().fotovideo(context).then((value) {
                            izin = value;
                            print("Dosya izni:$izin");
                          });
                          if (izin == false) return;
                          Get.back();

                          try {
                            for (int j = 0; j < url.length; j++) {
                              imageKaydet(url[j]);
                              Fluttertoast.cancel();
                              toast(msg: "${j + 1} fotoğraf indirildi.");
                            }
                          } catch (e) {
                            toast(msg: "Hata:" + e.toString());
                            debugPrint(e.toString());
                            return;
                          }
                          toast(msg: "İndirme işlemi bitirildi!");
                        },
                        child: Text("Albümü İndir")),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Center(
        child: ExtendedImage.network(
          url[i],
          fit: BoxFit.contain,
          height: Get.height,
          //enableLoadState: false,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true,
              initialAlignment: InitialAlignment.center,
            );
          },
        ),
      ),
    ));
  }

  return Scaffold(
    body: Stack(
      children: [
        Container(
          color: Colors.white,
          child: CarouselSlider(
            options: CarouselOptions(
                height: Get.height,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                pageSnapping: true,
                onPageChanged: (value, reason) {
                  // debugPrint("value:" + value.toString());
                  c.gunlukAkisAlbumSeciliFotograf.value = value;
                }),
            items: fotoList,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      debugPrint(url[c.gunlukAkisAlbumSeciliFotograf.value]);
                      urlAc(url: url[c.gunlukAkisAlbumSeciliFotograf.value]);
                    },
                    child: Text("Link", style: TextStyle(color: Colors.black))),
                SizedBox(width: 20, height: 0),
                Obx(
                  () => Text(
                      (c.gunlukAkisAlbumSeciliFotograf.value + 1).toString() +
                          "/" +
                          url.length.toString(),
                      style: TextStyle()),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> fotograflar(
    {required List<String> url, required COgretmen c, required String etkinlikId}) {
  List<Widget> l = [];
  l.add(GestureDetector(
    onTap: () {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return fotoAlbum(url: url, c: c);
          });
    },
    child: Stack(
      children: [
        CachedNetworkImage(
          imageUrl: url[0],
          width: Get.width - 20,
          height: 320,
          fit: BoxFit.cover,
        ),
        Positioned(
            right: 10,
            top: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
              child: Text("+" + (url.length).toString(), style: TextStyle()),
            ))
      ],
    ),
  ));

  return l;
}
