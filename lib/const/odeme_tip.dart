class OdemeTip {
  static int odenmedi = -1;
  static int nakit = 0;
  static int krediKarti = 1;
  static int havaleEft = 2;
  static int onlineOdeme = 3;

  static String getOdemeText(int odemeTip) {
    if (odemeTip == odenmedi) {
      return "Ödenmedi";
    }
    if (odemeTip == nakit) {
      return "Nakit";
    }
    if (odemeTip == krediKarti) {
      return "Kredi Kartı";
    }
    if (odemeTip == havaleEft) {
      return "Havale/EFT";
    }
    return "Online Ödeme";
  }
}
