import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Izin {
  String foto = "fotoizin".tr;
  String mic = "mikroizin".tr;
  String camera = "kameraizin".tr;
  String konumtext = "konumizin".tr;

  Future<bool> microfon(BuildContext context) async {
    bool izin = false;
    print(009);

    var status = await Permission.microphone.status;

    print(010);
    print(status.toString());

    if (status.isPermanentlyDenied || status.isRestricted) {
      //status.isRestricted ne olur ne olmaz diye
      //uygulama kalıcı engellenmiş
      izin_uyari(context, mic);
      return false;
    }

    print(020);

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }
    print(030);

    if (status.isDenied) {
      //engellenmiş, tekrar izin iste
      await Permission.microphone.request().then((value) {
        if (value.isGranted || value.isLimited) {
          print("1izin alındı.");
          izin = true;
        } else {
          izin_uyari(context, mic);

          izin = false;
        }
      });
      return izin;
    }
    print(40);

    //ne olur ne olmaz
    izin_uyari(context, mic);
    return false;
  }

  Future<bool> konum() async {
    bool izin = false;
    var status = await Permission.location.status;

    print("1" + status.toString());

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }
    status = await Permission.locationAlways.status;
    print("2" + status.toString());

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }
    status = await Permission.locationWhenInUse.status;
    print("3" + status.toString());

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }

    //engellenmiş, tekrar izin iste
    status = await Permission.location.request().then((value) {
      if (value.isGranted || value.isLimited) {
        print("1izin alındı.");
        izin = true;
      } else {
        izin = false;
        Pencere().ac(
            content: Text(konumtext, style: TextStyle()),
            context: Get.context!,
            baslik: "okulageliyorum".tr);
      }
      return value;
    });

    return izin;
  }

  Future<bool> fotovideo(BuildContext context) async {
    return true; //web için izin iptal edildi
    bool izin = false;

    var status = await Permission.mediaLibrary.request();
    print("izin durumu:" + status.toString());

    if (status.isRestricted) {
      //uygulama kalıcı engellenmiş,ayarlardan manuel izin verilmeli
      izin_uyari(context, foto);
      return false;
    }

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }

    if (status.isDenied) {
      //engellenmiş, tekrar izin iste
      await Permission.photos.request().then((value) {
        if (value.isGranted || value.isLimited) {
          print("1izin alındı.");
          izin = true;
        } else {
          print("2izin alınamadı");
          izin_uyari(context, foto);
          izin = false;
        }
      });
      return izin;
    }

    return false;
  }

  Future<bool> dosyalar(BuildContext context) async {
    print(0);
    bool izin = false;
    var status = await Permission.storage.status;

    print(1);
    print(status.toString());

    if (status.isRestricted) {
      //status.isRestricted ne olur ne olmaz diye
      //uygulama kalıcı engellenmiş
      izin_uyari(context, foto);
      return false;
    }

    print(2);

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }
    print(3);

    if (status.isDenied) {
      //engellenmiş, tekrar izin iste
      await Permission.storage.request().then((value) {
        if (value.isGranted || value.isLimited) {
          print("1izin alındı.");
          izin = true;
        } else {
          print("2izin alınamadı");
          izin_uyari(context, foto);
          izin = false;
        }
      });
      return izin;
    }
    print(4);

    //ne olur ne olmaz
    izin_uyari(context, foto);

    return false;
  }

  Future<dynamic> izin_uyari(BuildContext context, String uyari) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(uyari),
              MaterialButton(
                  onPressed: () async {
                    await Permission.mediaLibrary.request();
                  },
                  child: Text("izinver".tr)),
            ],
          ),
        );
      },
    );
  }

  Future<bool> kamera(BuildContext context) async {
    print(0);
    bool izin = false;
    var status = await Permission.camera.status;

    print(1);
    print(status.toString());

    if (status.isRestricted) {
      //status.isRestricted ne olur ne olmaz diye
      //uygulama kalıcı engellenmiş
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("kameraengellenmis".tr),
          );
        },
      );
      return false;
    }

    print(2);

    if (status.isGranted || status.isLimited) {
      //izin verilmiş
      return true;
    }
    print(3);

    if (status.isDenied) {
      //engellenmiş, tekrar izin iste
      await Permission.camera.request().then((value) {
        if (value.isGranted || value.isLimited) {
          print("1izin alındı.");
          izin = true;
        } else {
          print("2izin alınamadı");
          izin_uyari(context, camera);
          izin = false;
        }
      });
      return izin;
    }
    print(4);

    //ne olur ne olmaz
    izin_uyari(context, camera);
    return false;
  }
}
