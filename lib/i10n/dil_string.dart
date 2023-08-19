import 'package:get/get.dart';

class DilStrings extends Translations {
  @override
  static Map<String, Map<String, String>> _keys = {};

  static void addKeys(Map<String, Map<String, String>> text) {
    _keys.addAll(text);
  }

  Map<String, Map<String, String>> get keys => _keys;
}
