import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OgretmenBizimleIletisim extends StatelessWidget {
  COgretmen c;

  OgretmenBizimleIletisim({Key? key, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "asset/image/menu_arkaplan.png",
            ),
            fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset("asset/image/logo_besadim.svg"),
          ],
        ),
      ),
    );
  }
}
