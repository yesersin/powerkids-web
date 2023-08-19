// Widget tarihKutusu({required COgretmen c}) {
//   return InkWell(
//     onTap: () {
//       DatePicker.showDatePicker(
//         Get.context!,
//         showTitleActions: true,
//         locale: getLocale(dil: cp.dil),
//         minTime: DateTime.now(),
//         maxTime: DateTime.now().add(Duration(days: 7)),
//         onConfirm: (date) {
//           c.akisTarih.value = date;
//         },
//         currentTime: DateTime.now(),
//
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
//               bottomLeft: Radius.circular(RadiusSabit.akisTextRadius),
//               topLeft: Radius.circular(RadiusSabit.akisTextRadius))),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Center(
//         child: Obx(
//           () => Text(
//             Tarih().gunAyYil(c.akisTarih.value),
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
