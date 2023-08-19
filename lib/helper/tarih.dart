import 'package:flutter/material.dart';

class Tarih {
  List<String> ayIsim = [
    "Ocak",
    "Şubat",
    "Mart",
    "Nisan",
    "Mayıs",
    "Haziran",
    "Temmuz",
    "Ağustos",
    "Eylül",
    "Ekim",
    "Kasım",
    "Aralık"
  ];

  String gunAyYilSaatDk(DateTime date) {
    String gun = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    String hour = date.hour < 10 ? "0${date.hour}" : date.hour.toString();
    String minute = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    return "$gun/$month/$year $hour:$minute";
  }

  String gunAyYil(DateTime date) {
    String gun = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    return "$gun/$month/$year";
  }

  String saatDk(DateTime date) {
    String hour = date.hour < 10 ? "0${date.hour}" : date.hour.toString();
    String minute = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    return "$hour:$minute";
  }

  String saatDkTimeOf(TimeOfDay date) {
    String hour = date.hour < 10 ? "0${date.hour}" : date.hour.toString();
    String minute = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    return "$hour:$minute";
  }

  String saatDkSn(DateTime date) {
    String hour = date.hour < 10 ? "0${date.hour}" : date.hour.toString();
    String minute = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    String second = date.second < 10 ? "0${date.second}" : date.second.toString();
    return "$hour:$minute:$second";
  }

  DateTime simdiDate() {
    return DateTime.now();
  }

  DateTime simdi() {
    return DateTime.now();
  }

  DateTime gunIleriGeri(int sayi) {
    if (sayi <= 0) {
      return DateTime.now().subtract(Duration(days: -1 * sayi));
    } else {
      return DateTime.now().add(Duration(days: sayi));
    }
  }

  String gunAyYilSaat(DateTime date) {
    String gun = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    String hour = date.hour < 10 ? "0${date.hour}" : date.hour.toString();
    String minute = date.minute < 10 ? "0${date.minute}" : date.minute.toString();
    return "$gun/$month/$year $hour:$minute";
  }

  String gunAyYilSecond(DateTime date) {
    String gun = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();

    return "$gun/$month/$year";
  }

  int toSecond(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  DateTime toDate(int second) {
    return DateTime.fromMillisecondsSinceEpoch(second);
  }

  static String gun() {
    return DateTime.now().day.toString();
  }

  static String ay() {
    return DateTime.now().month.toString();
  }

  static String yil() {
    return DateTime.now().year.toString();
  }

  static String gunDate(DateTime date) {
    return date.day.toString();
  }

  static String ayDate(DateTime date) {
    return date.month.toString();
  }

  static String yilDate(DateTime date) {
    return date.year.toString();
  }

  String sonMesajSaat({required DateTime tarih}) {
    int fark = DateTime.now().difference(tarih).inDays;
    if (fark < 0) {
      return saatDk(tarih);
    }
    return tarih.day.toString() + " " + ayIsim[tarih.month - 1];
  }

  String ayHesapla(DateTime date) {
    int fark = DateTime.now().difference(date).inDays;
    return (fark / 30).toInt().toString();
  }
}
