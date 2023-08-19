import 'dart:math';
import 'dart:ui';

class Renk {
  static final Color maviAcik = Color(0xff28A3DA); //değişti
  static final Color maviKoyu = Color(0xff2b96c6);
  static final Color turuncu = Color(0xffE6801D); //değişti
  static final Color turuncuAcik = Color(0xffFBB571); //değişti
  static final Color turuncuCanli = Color(0xffF1861D); //değişti
  static final Color kirmizi = Color(0xffe82b2f); //değişti
  static final Color griLogo = Color(0xffbbc0c4); //değişti
  static final Color griArkaplanKoyu = Color(0xff626161); //değişti

  static final Color yesil = Color(0xff88BE37); //değişti
  static final Color yesilBildirim = Color(0xff78E378); //değişti
  static final Color yesilSwitchKoyu = Color(0xff88BE37); //değişti
  static final Color yesilSwitchAcik = Color(0xffBEF074); //değişti
  static final Color sari = Color(0xffffc744);

  static final Color griMetin = Color(0xffADA4A5); //değişti
  static final Color griArkaplan = Color(0xffF5F4F2); //değişti
  static final Color beyazArkaplan = Color(0xffffffff); //değişti
  static final Color kahveNavBar = Color(0xff767372); //değişti

  static final Color beyazMetin = Color(0xffF5F4F2); //değişti
  static final Color beyazMetin2 = Color(0xff7b6f72); //değişti

  static final Color odemeSari = Color(0xffffd029); //değişti
  static final Color odemeYesil = Color(0xff88be37); //değişti
  static final Color odemeMavi = Color(0xff5daffe); //değişti

  static final List<Color> renkList = [
    maviAcik,
    turuncuCanli,
    sari,
    maviKoyu,
    kirmizi,
    yesil,
    turuncu,
  ];

  static Color rasgeleRenk() {
    return renkList[Random().nextInt(renkList.length)];
  }

  static Color numaraliRenk(int i) {
    return renkList[i % renkList.length];
  }
}
