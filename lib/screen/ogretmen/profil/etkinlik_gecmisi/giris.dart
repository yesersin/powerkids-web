// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:com.powerkidsx/component/card/yoklamaCard.dart';
// import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
//
// import '../../../../../const/renk.dart';
//
//
// class OgretmenEtkinlikGecmis extends StatelessWidget {
//   COgretmen c;
//
//   OgretmenEtkinlikGecmis({Key? key, required this.c}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage(
//               "asset/image/menu_arkaplan.png",
//             ),
//             fit: BoxFit.cover),
//       ),
//       child: Column(
//         children: [
//           Container(width: Get.width - 10),
//
//           Expanded(
//               child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 yoklamaCard(
//                   saat: "16:18:00",
//                   mesaj: "Ateş Derecesi",
//                   renk: Renk.yesil,
//                 ),
//                 SizedBox(height: 10),
//                 yoklamaCard(
//                   saat: "16:18:00",
//                   mesaj: "Bilgi",
//                   renk: Renk.maviAcik,
//                 ),
//               ],
//             ),
//           ))
//         ],
//       ),
//     );
//   }
// }
