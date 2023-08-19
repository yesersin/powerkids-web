import 'package:flutter/material.dart';

Locale getLocale({required String dil}) {
  if (dil == "TUR") {
    return Locale("tr", "TR");
  } else if (dil == "ENG") {
    return Locale("en", "US");
  } else if (dil == "ARB") {
    return Locale("ar", "ARB");
  } else if (dil == "RUS") {
    return Locale("ru", "RU");
  } else {
    return Locale("tr", "TR");
  }
}
