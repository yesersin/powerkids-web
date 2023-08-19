import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget secilenImajlar({required COgretmen c, required bool fotograf}) {
  return Container(
    height: Get.height * 0.2,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Obx(() {
      if (c.akisSecilenDosyalar.length == 0) {
        return Container(
          height: Get.height * 0.3,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text("Lütfen fotoğraf seçiniz."),
          ),
        );
      }
      if (fotograf) {
        debugPrint("1");
        return Container(
          height: 160,
          width: Get.width,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: c.akisSecilenDosyalar.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.memory(
                        c.akisSecilenDosyalar[index].bytes!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          c.akisSecilenDosyalar.removeAt(index);
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Text((index + 1).toString(), style: TextStyle()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      } else {
        debugPrint("2");
        return Container(
          height: 160,
          width: Get.width,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: c.akisSecilenDosyalar.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset("asset/image/logo_bosluklu.png"),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          c.akisSecilenDosyalar.removeAt(index);
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Text((index + 1).toString(), style: TextStyle()),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
    }),
  );
}
