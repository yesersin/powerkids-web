class YoklamaTip {
  //tip:0:beklemede,1 geldi, 2:gelmedi, 3:teslim edildi,4:teslim edilmedi,5:derse girdim,6:ders bitti.
  static final String beklemede = "0";
  static final String okula_geldi = "1";
  static final String okula_gelmedi = "2";
  static final String teslim_edildi = "3";
  static final String teslim_edilmedi = "4";
  static final String derse_girdim = "5";
  static final String ders_bitti = "6";

  String text(String tip) {
    if (tip == beklemede) {
      return "Beklemede";
    } else if (tip == okula_geldi) {
      return "Okula Geldi";
    } else if (tip == okula_gelmedi) {
      return "Okula Gelmedi";
    } else if (tip == teslim_edildi) {
      return "Teslim Edildi";
    } else if (tip == teslim_edilmedi) {
      return "Teslim Edilmedi";
    } else if (tip == derse_girdim) {
      return "Derse Girdim";
    } else if (tip == ders_bitti) {
      return "Ders Bitti";
    } else {
      return "Tip bulunamadı!";
    }
  }
}
