import 'dart:io';

import 'package:com.powerkidsx/component/custom/yukleniyor.dart';
import 'package:com.powerkidsx/const/renk.dart';
import 'package:com.powerkidsx/const/shared_pref_keys.dart';
import 'package:com.powerkidsx/const/versiyon.dart';
import 'package:com.powerkidsx/controller/program/c_program.dart';
import 'package:com.powerkidsx/helper/internet_kontrol.dart';
import 'package:com.powerkidsx/helper/locale_gonder.dart';
import 'package:com.powerkidsx/helper/shared_pref.dart';
import 'package:com.powerkidsx/i10n/dil_string.dart';
import 'package:com.powerkidsx/login/helper/user_check.dart';
import 'package:com.powerkidsx/login/login.dart';
import 'package:com.powerkidsx/login/uygulama_guncelle.dart';
import 'package:com.powerkidsx/model/web_api/besadim.dart';
import 'package:com.powerkidsx/service/besadim/besadim_getir.dart';
import 'package:com.powerkidsx/static/cprogram.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'helper/bildirim/notification_ayarlar.dart';
import 'helper/dil_string_olustur.dart';
import 'login/yetki_sec_sayfa.dart';

late ModelBesadim? _besadim;
String _dil = "";

//sertifika hatası
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides(); //sertifika hatası
  bool internet = await Internet().varmi();
  if (internet == false) {
    besadimYok(mesaj: "Cannot connect to server!"); //bu textleri değiştirme
    return;
  }
  await _init();

  if (_besadim == null) {
    besadimYok(mesaj: "Configuration cannot be resolved!"); //bu textleri değiştirme
    return;
  } else {
    //defaultTargetPlatform==TargetPlatform.android
    runApp(
      GlobalLoaderOverlay(
        overlayColor: Colors.white,
        overlayOpacity: 0.7,
        child: GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("tr", "TR"),
            Locale("en", "US"),
          ],
          locale: getLocale(dil: _dil),
          translations: DilStrings(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.circularReveal,
          transitionDuration: const Duration(milliseconds: 1000),
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
            }),
            backgroundColor: Renk.beyazArkaplan,
            scaffoldBackgroundColor: Renk.beyazArkaplan,
            appBarTheme: AppBarTheme(
                backgroundColor: Renk.beyazArkaplan,
                foregroundColor: Colors.black,
                elevation: 0),
          ),
          home: const SafeArea(
            child: Main(),
          ),
        ),
      ),
    );
  }
}

Future<void> _init() async {
  //web firebase başlangıç
  debugPrint("web firebase");
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyB4w55OAd9SDZBUspVZlo8eytWG8AY7EN4',
      appId: '1:1047764427243:ios:0ee399e29f1a364f61f9ae',
      messagingSenderId: '1047764427243',
      projectId: 'powerkids-app',
    ),
  );

  await notificaionAyarlar();
  firebaseNotificationAyarlar();
  cp = Get.put(CProgram(), tag: "cprogram", permanent: true); //program genel controller
  _besadim = await getBesadim();
  if (_besadim != null) {
    cp.besadim = _besadim!;
    dilStringOlustur();
  }
  _dil = await Shared().get(key: SharedKeys().dil);
  if (_dil == "") {
    cp.dil = "TUR";
  } else {
    cp.dil = _dil;
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  var checkUserService;
  bool _first = true;

  @override
  Widget build(BuildContext context) {
    //versiyon kontrol
    if (defaultTargetPlatform == TargetPlatform.android &&
        double.parse(cp.besadim.data.first.andV) > double.parse(androidVersion)) {
      return UygulamaGuncelle();
    }
    if (defaultTargetPlatform == TargetPlatform.iOS &&
        double.parse(cp.besadim.data.first.iosV) > double.parse(iosVersion)) {
      return UygulamaGuncelle();
    }
    //versiyon kontrol

    return checUserLogin();
  }

  Widget checUserLogin() {
    return FutureBuilder(
      future: checkUserService,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: yukleniyor());
        } else {
          if (snapshot.data == false) {
            return LoginEkran();
          }

          return LoginYetkiSecSayfa();
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserService = checkUserLocal();
  }
}

void besadimYok({required String mesaj}) {
  runApp(GetMaterialApp(
    locale: getLocale(dil: _dil),
    translations: DilStrings(),
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.circularReveal,
    transitionDuration: const Duration(milliseconds: 1000),
    theme: ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      }),
      useMaterial3: true,
      backgroundColor: Renk.beyazArkaplan,
      scaffoldBackgroundColor: Renk.beyazArkaplan,
      appBarTheme: AppBarTheme(backgroundColor: Renk.beyazArkaplan, elevation: 0),
    ),
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text(mesaj)),
    ),
  ));
}
