import '../i10n/dil_string.dart';
import '../static/cprogram.dart';

void dilStringOlustur() {
  for (var element in cp.besadim.data.first.diller) {
    if (element == "TUR") {
      DilStrings.addKeys({"tr_TR": cp.besadim.data.first.dil.tur});
    } else if (element == "ENG") {
      DilStrings.addKeys({"en_US": cp.besadim.data.first.dil.eng});
    } else if (element == "ARB") {
      DilStrings.addKeys({"ar_AR": cp.besadim.data.first.dil.arb});
    } else if (element == "RUS") {
      DilStrings.addKeys({"ru_RU": cp.besadim.data.first.dil.rus});
    }
  }
}
