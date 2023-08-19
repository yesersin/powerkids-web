import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.powerkidsx/component/custom/telefon_ara.dart';
import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/model/web_api/okul/okul_hakkinda.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../component/card/beyaz_card.dart';
import '../../../../service/okul/okul_hakkinda_getir.dart';

class OgretmenHakkimizda extends StatelessWidget {
  const OgretmenHakkimizda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOkulHakkinda(token: cp.kullanici.token, okulId: cp.okul!.data.id),
      builder: (BuildContext context, AsyncSnapshot<ModelOkulHakkinda?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return yukleniyor();
        }
        if (snapshot.data == null) {
          return Text("Okul bilgileri getirilemedi!", style: TextStyle());
        } else {
          return body(okul: snapshot.data!);
        }
      },
    );
  }

  Widget body({required ModelOkulHakkinda okul}) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: [
          logo(okul),
          amac(okul),
          SizedBox(height: 10),
          telefon(okul: okul),
          SizedBox(height: 10),
          mail(okul),
          SizedBox(height: 10),
          konum(okul),
          SizedBox(height: 10),
          tesekkur(),
          SizedBox(height: 50),
        ],
      )),
    );
  }

  Container tesekkur() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x111d1617),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(width: Get.width),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset("asset/image/tesekkur.svg")],
          ),
        ],
      ),
    );
  }

  Widget telefon({required ModelOkulHakkinda okul}) {
    return beyazCard(
      baslik: "Telefon",
      icerik: telefonWidget(tel: okul.data.telefon, whatsapp: okul.data.whatsapp),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget mail(ModelOkulHakkinda okul) {
    return GestureDetector(
      onTap: () {
        // telefonAra("+902165260786");
        final Uri emailLaunchUri = Uri(
          scheme: 'mailto',
          path: okul.data.mail,
          query: encodeQueryParameters(<String, String>{
            'subject': 'Merhaba',
          }),
        );

        launchUrl(emailLaunchUri);
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x111d1617),
              blurRadius: 40,
              offset: Offset(0, 10),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(width: Get.width),
            Row(
              children: const [
                Text(
                  "Mail Adres",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "asset/image/mail.svg",
                    height: 24,
                  ),
                  SizedBox(width: 5),
                  Text(
                    okul.data.mail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Renk.beyazMetin2,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container amac(ModelOkulHakkinda okul) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x111d1617),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            okul.data.okulAdi,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            okul.data.aciklama,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Renk.beyazMetin2,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Container konum(ModelOkulHakkinda okul) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x111d1617),
            blurRadius: 40,
            offset: Offset(0, 10),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Adres",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            okul.data.adres.acikadres,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Renk.beyazMetin2,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(
                  "https://www.google.com/maps/search/?api=1&query=${okul.data.adres.lat},${okul.data.adres.lng}"));
            },
            child: Text(
              "Konuma Git",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  CachedNetworkImage logo(ModelOkulHakkinda okul) {
    return CachedNetworkImage(
      imageUrl: okul.data.logo,
      height: Get.height * 0.3,
    );
  }
}
