import 'package:com.powerkidsx/component/custom/button.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/controller/login/c_login.dart';
import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:com.powerkidsx/login/helper/user_check.dart';
import 'package:com.powerkidsx/login/widget/kvkk.dart';
import 'package:com.powerkidsx/login/widget/sifre_text_widget.dart';
import 'package:com.powerkidsx/login/widget/sifremi_unuttum/sifremi_unuttum_btn.dart';
import 'package:com.powerkidsx/login/widget/sifremi_unuttum/sifremi_unuttum_widget.dart';
import 'package:com.powerkidsx/login/widget/telefon_text_widget.dart';
import 'package:com.powerkidsx/login/widget/ust_logo.dart';
import 'package:com.powerkidsx/login/yetki_sec_sayfa.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../const/versiyon.dart';
import '../const/shared_pref_keys.dart';

TextEditingController _telefon = TextEditingController(text: ""); //5462947291
TextEditingController _sifre =
    TextEditingController(text: ""); //6ac1e56bc78f031059be7be854522c4c
// TextEditingController telefon = TextEditingController();
// TextEditingController sifre = TextEditingController();
late CLogin c;

class LoginEkran extends StatefulWidget {
  const LoginEkran({Key? key}) : super(key: key);

  @override
  State<LoginEkran> createState() => _LoginEkranState();
}

class _LoginEkranState extends State<LoginEkran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBody: false,
      // backgroundColor: Colors.white,
      body: Obx(
        () => Container(
          width: Get.width,
          height: Get.height,
          child:
              (c.sifreUnuttum.value) ? sifremiUnuttumWidget(telefon: _telefon) : loginWidget(),
        ),
      ),
    );
  }

  Widget loginWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ustLogo(image: "asset/image/giris_ust.png"),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                telefonTextWidget(telefon: _telefon),
                SizedBox(height: 10),
                sifreTextWidget(c: c, sifre: _sifre),
                kvkkWidget(c: c),
                girisButton(),
                sifremiUnuttumBtn(telefon: _telefon),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "asset/image/giris_alt.png",
                width: Get.width * 0.8,
              ),
              Positioned(
                bottom: 5,
                child: Text(
                  defaultTargetPlatform == TargetPlatform.iOS
                      ? "v" + iosVersion
                      : "v" + androidVersion,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8,
                    decoration: TextDecoration.underline,
                    color: Renk.griMetin,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget girisButton() {
    return Buton().mavi(
        text: "gonder".tr,
        // text: "Giriş Yap",
        click: () async {
          Get.context!.loaderOverlay.show();
          bool result = await checkUserOnline(telefon: _telefon.text, sifre: _sifre.text);
          Get.context!.loaderOverlay.hide();
          if (result) {
            Shared().save(key: SharedKeys().telefon, value: _telefon.text);
            Shared().save(key: SharedKeys().sifre, value: _sifre.text);
            Get.off(() => LoginYetkiSecSayfa());
          } else {
            debugPrint("Kullanıcı bulunamadı!");
            toast(msg: "Bilgiler hatalı, kullanıcı bulunamadı!");
            // Pencere().ac(
            //     content: Center(child: Text("Kullanıcı bulunamadı!", style: TextStyle())),
            //     context: Get.context!);
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c = Get.put(CLogin(), tag: "logincontroller");
  }
}
