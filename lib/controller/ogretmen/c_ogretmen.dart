import 'package:com.powerkidsx/model/bos_model/ogrenci.dart';
import 'package:com.powerkidsx/model/etkinlik_ekle.dart';
import 'package:com.powerkidsx/model/ogrenci_yemek_secimi.dart';
import 'package:com.powerkidsx/model/veli_gunluk_akis.dart';
import 'package:com.powerkidsx/model/web_api/duyuru/duyuru_gelen.dart';
import 'package:com.powerkidsx/model/web_api/etkinlik.dart';
import 'package:com.powerkidsx/model/web_api/gunluk_akis.dart';
import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_ogretmen_list.dart';
import 'package:com.powerkidsx/model/web_api/mesaj/mesaj_sohbet_list.dart';
import 'package:com.powerkidsx/model/web_api/sinif_ogrencileri.dart';
import 'package:com.powerkidsx/model/web_api/yemek_menu_okul.dart';
import 'package:com.powerkidsx/model/web_api/yonetici_etkinlik_akis.dart';
import 'package:com.powerkidsx/model/yoklama_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../data/etkinlik_listesi.dart';
import '../../model/bos_model/ogrenci_get.dart';
import '../../model/web_api/ders_program.dart';
import '../../model/web_api/mesaj/mesaj_esle_veli_ogretmen.dart';
import '../../model/web_api/mesaj/mesaj_veli_list.dart';
import '../../model/web_api/mesaj/mesaj_veli_ogretmen.dart';
import '../../model/web_api/ogrenci/ogrenci_etklnlik_gecmis.dart';
import '../../model/web_api/ogrenci/ogrenci_get.dart';
import '../../model/web_api/ogrenci/ogrenci_ilac.dart';
import '../../model/web_api/ogrenci/ogrenci_yoklama_gecmis.dart';
import '../../model/web_api/yoklama/yoklama.dart';
import '../../screen/ogretmen/anasayfa/ogretmen_anasayfa_giris.dart';
import '../../screen/ogretmen/mesaj/mesaj_giris.dart';
import '../../screen/ogretmen/profil/ogretmen_profil_giris.dart';
import '../../screen/ogretmen/widget/fotograf_video_ekle.dart';
import '../../screen/ogretmen/yoklama/yoklama_giris.dart';
import '../../screen/veli2/anasayfa/veli_anasayfa_giris.dart';
import '../../screen/veli2/mesaj/mesaj_giris.dart';
import '../../screen/veli2/profil/veli_ogrenci_profil_giris.dart';
import '../../screen/yonetici/anasayfa/anasayfa_giris.dart';
import '../../screen/yonetici/ekle/ekle_giris.dart';
import '../../screen/yonetici/mesaj/mesaj_giris.dart';
import '../../screen/yonetici/profil/yonetici_profil_giris.dart';
import '../../screen/yonetici/rapor/rapor1_giris.dart';

class COgretmen extends GetxController {
  var ogretmenTabController = PersistentTabController(initialIndex: 0);
  var sayfaSecilenIndex = 0.obs;
  var sayfaTitle = "".obs;
  var secilenTarih = DateTime.now().obs;

  //sayfa kontrolü
  var bildirimSayfasi = false.obs; //bildirim sayfası açık mı
  var syfGunlukAkis = false.obs; //günlük akış sayfası için
  var syfFotografYukle = false.obs; //günlük akışa fotoğraf yükle sayfası
  var syfEtkinlikler = false.obs; //etkinlikler sayfası
  var syfDersProgram = false.obs; //ders programı sayfası
  var syfYemekMenu = false.obs; //ders programı sayfası
  var syfYemekAyrinti = false.obs; //ders programı sayfası
  var syfHakkinda = false.obs; //ders programı sayfası
  var syfDuyuru = false.obs; //ders programı sayfası

  //

  //günlük akış yükleme işlemleri
  var akis = <GunlukAkisData>[].obs;
  var akisSecilenDosyalar = <PlatformFile>[].obs; //secilenlerin dosya bilgisi tutar
  var akisTarih = DateTime.now().obs;

  // var akisSaat = DateTime.now().obs;
  var yuklenenDosyaSayisi = 1.obs; //günlük akışta fotoğraf yüklenirken gösterilecek
  List<String> yuklenenDosyaUrl = [];

  // var getAkisService = gunlukAkisGetir(
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   sinifId: cp.sinif.id,
  //   tarih: DateTime.now(),
  //   yetki: yetkiText,
  // ).obs; //günlük akış get service
  var gunlukAkisAlbumSeciliFotograf = 0.obs;

  //

  //duyurular
  var duyuruList = <ModelDuyuru>[].obs;
  var duyuruDuzenlePin = false.obs;
  var duyuruEkleSecilenDosyalar = <PlatformFile>[].obs; //secilenlerin dosya bilgisi tutar
  var duyuruVeliOnaylasinmi = false.obs;
  var duyuruVeli = true.obs;
  var duyuruOgretmen = true.obs;
  var duyuruEbeveyn = true.obs;

  //

  //yoklama sayfası
  var yoklamaSecilen = ModelYoklamaBtn(text: "", tip: "").obs;
  Rx<ModelSinifOgrencileri?> ogrenciList = ModelSinifOgrencileri(success: -1, data: []).obs;
  var yoklamaCheck = <bool>[].obs;
  var yoklamaBeklemede = <String>[].obs;

  //yoklama sayfası

  //profil sayfası kontrolü
  var pOgrenciProfilleri = false.obs;
  var pKisiselBilgiler = false.obs;
  var pEtkinlikGecmisi = false.obs;
  var pBildirimler = false.obs;
  var pIletisim = false.obs;
  var pGizlilikPolitika = false.obs;
  var pCikis = false.obs;

  //nav bar profil widget sayfa listesi
  List<Widget> profilSayfalari = [OgretmenProfilGiris()];
  List<Widget> anasayfaSayfalari = [OgretmenAnasayfaGiris()];

  //yemek menüsü
  var yemekSecilenTarih = DateTime.now().obs;
  var yemekMenuOkul = ModelYemekMenuOkul(success: 0, data: []).obs;

  // var yemekMenuGetirServis = yemekProgramOkulGetir(
  //         dil: cp.dil,
  //         token: cp.kullanici.token,
  //         okulId: cp.okul!.data.id,
  //         ay: Tarih.ayDate(DateTime.now()),
  //         gun: Tarih.gunDate(DateTime.now()),
  //         yil: Tarih.yilDate(DateTime.now()))
  //     .obs;
  var yemekMenuOgrenciSecilen = <ModelOgrenciYemekSecimi>[].obs;
  var yemekMenuOgrenciBeklemede = <bool>[].obs;

  void yemekSec({required String yemekAdi, required int ogrenciIndex}) {
    int index = yemekMenuOgrenciSecilen[ogrenciIndex]
        .yemekSecili
        .indexWhere((element) => element == yemekAdi);
    if (index != -1) {
      yemekMenuOgrenciSecilen[ogrenciIndex].yemekSecili.removeAt(index);
    } else {
      yemekMenuOgrenciSecilen[ogrenciIndex].yemekSecili.add(yemekAdi);
    }
    yemekMenuOgrenciSecilen.refresh();
  }

  //yemek menüsü

  //ders programı
  var dersProgramSecilenTarih = DateTime.now().obs;
  late Rx<Future<ModelDersProgram?>> dersProgramServis;

  // dersProgramServis = dersProgramOkulGetir(
  //   token: cp.kullanici.token,
  //   ay: Tarih.ayDate(DateTime.now()),
  //   gun: Tarih.gunDate(DateTime.now()),
  //   yil: Tarih.yilDate(DateTime.now()),
  //   okulId: cp.okul!.data.id,
  //   tip: cp.okulAyarlar.data.dersProgrami,
  //   sinifId: cp.sinif.id,
  //   donem: cp.okulAyarlar.data.donem,
  //   ogretmenId: cp.kullanici.data.id,
  //   brans: cp.kullanici.data.yetki.brans,
  // ).obs;
  var secilenNotBaslik = "".obs;
  var secilenNotDurum = true.obs;
  var dersProgramNotEkleSecilenDosyalar = <PlatformFile>[].obs;
  GroupButtonController haftalikBtnController = GroupButtonController(selectedIndex: 0);
  TextEditingController notText = TextEditingController();
  List<String> secilenNotBaslikList = ["odev".tr, "not".tr];

  //ders programı

  //etkinlikler
  var etkinlikler = <Etkinlik>[];
  var etkinliklerOgrenciSecilen = <ModelEtkinlikEkleOgrenci>[].obs;
  var etkinlikListe = EtkinlikListesi.list.obs;
  var seciliEtkinlik = Etkinlik(
          id: "",
          okulId: "",
          tip: "",
          seciliSecenek: "",
          etkinlikAdi: "",
          secenekBir: "",
          secenekIki: "",
          secenekUc: "",
          secenekDort: "",
          dil: "",
          durum: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          v: 0)
      .obs; //dropdown
  //etkinlikler

  //mesaj sayfası
  var mesajSayfa = sample().obs;
  List<MesajVeliBilgi> mesajVeliList = [];
  List<MesajOgretmenBilgi> mesajOgretmenList = [];
  List<MesajSohbetData> mesajSohbetList = [];
  var mesajArananText = "".obs;
  var mesajEsleVeliOgretmen = MesajEsleVeliOgretmenData(
      id: "id",
      okulId: "okulId",
      veliId: "veliId",
      guncellemeZamani: DateTime.now(),
      ogretmenId: "ogretmenId",
      vOkunmayan: 0,
      oOkunmayan: 0,
      sonMesaj: "sonMesaj",
      durum: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0);
  var mesajList = <MesajData>[].obs;
  var messages = <types.Message>[].obs;
  var mesajGonderen, mesajAlan, mesajAdmin; //mesaj sayfası user
  int mesajPage = 1;
  late String mesajEsleId, mesajGonderenId, mesajGonderenAd, mesajVeliId, mesajVeliAd;
  TextEditingController mesajText = TextEditingController();
  var mesajAdminTiklananOgretmen = "".obs;
  late GroupButtonController mesajTabController;
  var mesajOkunmayanSayi = 0.obs;

  //mesaj sayfası

  //profil
  //kişisel bilgiler
  var profilAdSoyad = "".obs;
  var profilTelefon = "".obs;
  var profilSifre = "".obs;
  var profilDogumTarihi = DateTime.now().obs;
  var profilDogumTarihiText = "";
  var profilFotoUrl = "".obs;
  var profilCVBilgiler = "".obs;
  var profilGorunme = false.obs;
  late Rx<Future<ModelOgrenciEtkinlikGecmis?>> profilOgrenciEtkinlikAkisServis;

  // var profilOgrenciEtkinlikAkisServis = ogrenciEtkinlikGecmisiGetir(
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   dil: cp.dil,
  //   ogrenciId: "",
  //   tarih: DateTime.now(),
  // ).obs;
  var profilOgrenciGecmisEtkinlikList = <OgrenciEtkinlikGecmis>[].obs;

  late Rx<Future<ModelOgrenciYoklamaGecmis?>> profilOgrenciYoklamaServis;

  // var profilOgrenciYoklamaServis = ogrenciYoklamaGecmisiGetir(
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   dil: cp.dil,
  //   ogrenciId: "",
  //   tarih: DateTime.now(),
  // ).obs;
  var profilOgrenciYoklamaGecmisList = <OgrenciYoklamaGecmis>[].obs;
  var profilOgrenciAdSoyad = "".obs;
  var profilOgrenciSinif = "".obs;
  var profilOgrenciSinifId = "".obs;
  var profilOgrenciKimlikNo = "".obs;
  var profilOgrenciDogumTarihi = DateTime.now().obs;
  var profilSecilenOgrenci = bosOgrenci().obs;
  late Rx<Future<ModelOgrenciIlac?>> profilOgrenciIlacServis;

  // var profilOgrenciIlacServis = ogrenciIlacGetir(
  //   token: cp.kullanici.token,
  //   sinifId: cp.sinif.id,
  //   dil: cp.dil,
  //   ogrenciId: "",
  //   tarih: DateTime.now(),
  // ).obs;
  var profilOgrenciIlacList = <OgrenciIlacData>[].obs;

  //kişisel bilgiler

  //profil

  var ogretmenSayfalar = <Widget>[
    OgretmenAnasayfaGiris(),
    OgretmenYoklamaGiris(),
    FotografVideoEkle(),
    OgretmenMesajGiris(),
    OgretmenProfilGiris(),
  ].obs;

  //bildirim sayfası açılırken, yüklenmiş olan sayfalar
  //bu değişkene atılacak
  var tempSayfalar = <Widget>[].obs;

  ////*****////veli sayfası////
  var veliTabController = PersistentTabController(initialIndex: 0);
  var veliSayfalar = <Widget>[
    VeliAnasayfaGiris(),
    VeliMesajGiris(),
    VeliOgrenciProfilGiris(),
  ].obs;

  List<Widget> veliProfilSayfalari = [VeliOgrenciProfilGiris()];
  List<Widget> veliAnasayfaSayfalari = [VeliAnasayfaGiris()];
  var veliOgrenciList = <ModelOgrenciGet>[].obs;
  var veliSecilenOgrenci = bosGetOgrenci().obs;
  var veliYoklamaSayfaEkleBtn = false.obs;
  var veliIlacSayfaEkleBtn = false.obs;
  var veliIlacEkleSaat = TimeOfDay.now().obs;
  var veliAileKartiOzelNot = "".obs;
  var veliAileKartiYemekEgitimi = "".obs;
  var veliAileKartiAlerjikDurumu = "".obs;
  var veliAileKartiKorkular = "".obs;
  var veliAileKartiTuvaletEgitimi = "".obs;
  var veliAileKartiSaglikDurumu = "".obs;
  var veliAileKartiAliskanliklari = "".obs;
  var veliGetAkisService;

  // var veliGetAkisService = veliGunlukAkisGetir(
  //   ogrenciId: "",
  //   dil: cp.dil,
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   sinifId: cp.sinif.id,
  //   tarih: DateTime.now(),
  //   yetki: yetkiText,
  // ).obs; //anasayfa, günlük akış için
  var veliAkisList = <ModelVeliGunlukAkis>[].obs;

////*****////veli sayfası////

//yönetici sayfası
  var yoneticiTabController = PersistentTabController(initialIndex: 0);
  var yoneticiSayfalar = <Widget>[
    YoneticiAnasayfaGiris(),
    YoneticiEkleGiris(),
    YoneticiMesajGiris(),
    YoneticiRaporGiris(),
    YoneticiProfilGiris(),
  ].obs;

  List<Widget> yoneticiAnasayfaSayfalari = [YoneticiAnasayfaGiris()];
  List<Widget> yoneticiEkleSayfalari = [YoneticiEkleGiris()];
  List<Widget> yoneticiMesajSayfalari = [YoneticiMesajGiris()];
  List<Widget> yoneticiRaporSayfalari = [YoneticiRaporGiris()];
  List<Widget> yoneticiProfilSayfalari = [YoneticiProfilGiris()];

  var yoneticiVeliEkle = false.obs;
  var yoneticiDuyuruEkle = false.obs;
  var yoneticiOgretmenEkle = false.obs;
  var yoneticiOgrenciEkle = false.obs;
  var yoneticiVeliGuncelle = false.obs; //veli ekle sayfasını güncellemek için
  var yoneticiOgrenciGuncelle = false.obs; //öğrenci ekle sayfasını güncellemek için
  var yoneticiOgretmenGuncelle = false.obs; //öğrenci ekle sayfasını güncellemek için
  var yoneticiDuyuruGuncelle = false.obs; //öğrenci ekle sayfasını güncellemek için
  var getYoneticiAkisService;

  // var getYoneticiAkisService = yoneticiEtkinlikAkisGetir(
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   sinifId: cp.sinif.id,
  //   tarih: DateTime.now(),
  // ).obs;
  var yoneticiEtkinlikAkis = <YoneticiEtkinlikAkisData>[].obs;
  var getYoneticiYoklamaAkisService;

  // var getYoneticiYoklamaAkisService = yoklamaGetir(
  //   token: cp.kullanici.token,
  //   okulId: cp.okul!.data.id,
  //   sinifId: cp.sinif.id,
  //   tip: "0",
  //   ay: Tarih.ay(),
  //   gun: Tarih.gun(),
  //   yil: Tarih.yil(),
  //   dil: cp.dil,
  // ).obs;
  var yoneticiYoklamaAkis = <ModelYoklamaOgrenci>[].obs;

//yönetici sayfası

  var video = 0.obs; //video indirme yüzdesi
}

Widget sample() {
  //mesaj sayfasındaki tab body için obx örneği
  return Text("");
}
