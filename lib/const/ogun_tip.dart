class Ogun {
  static final String kahvalti = "1";
  static final String oglen = "2";
  static final String ikindi = "3";

  static String getOgun(String tip) {
    if (tip == kahvalti) {
      return "Sabah Kahvaltısı";
    } else if (tip == oglen) {
      return "Öğlen";
    } else if (tip == ikindi) {
      return "İkindi";
    } else {
      return "Kayıt yok!";
    }
  }

  static String getOgunAsset(String tip) {
    if (tip == kahvalti) {
      return "asset/image/kahvalti.svg";
    } else if (tip == oglen) {
      return "asset/image/ogle_yemegi.svg";
    } else if (tip == ikindi) {
      return "asset/image/ikindi_ogunu.svg";
    } else {
      return "Kayıt yok!";
    }
  }
}
