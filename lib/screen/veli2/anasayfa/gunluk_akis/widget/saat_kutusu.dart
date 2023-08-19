// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
//
// import '../../../../../const/radius.dart';
// import '../../../../../const/renk.dart';
// import '../../../../../helper/tarih.dart';
//
// Widget saatKutusu({required COgretmen c}) {
//   return InkWell(
//     onTap: () {
//       DatePicker.showTimePicker(
//         Get.context!,
//         showTitleActions: true,
//         showSecondsColumn: false,
//         onConfirm: (date) {
//           c.akisTarih.value = date;
//         },
//         currentTime: DateTime.now(),
//         locale: LocaleType.tr,
//         theme: DatePickerTheme(
//           cancelStyle: TextStyle(color: Colors.white),
//           doneStyle: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//           ),
//         ),
//       );
//     },
//     child: Container(
//       width: Get.width * 0.4,
//       decoration: BoxDecoration(
//           color: Renk.yesil,
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(RadiusSabit.akisTextRadius),
//               topRight: Radius.circular(RadiusSabit.akisTextRadius))),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Center(
//         child: Obx(
//           () => Text(
//             Tarih().saatDk(c.akisTarih.value),
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
