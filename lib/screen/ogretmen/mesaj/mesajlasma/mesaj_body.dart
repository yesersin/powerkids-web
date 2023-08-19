import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/screen/ogretmen/anasayfa/gunluk_akis/widget/akis_video.dart';
import 'package:com.powerkidsx/static/yetki.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../component/custom/yukleniyor.dart';
import '../../../../const/mesaj_tip.dart';
import '../../../../helper/toast.dart';
import '../../../../model/web_api/mesaj/mesaj_veli_ogretmen.dart';
import '../../../../service/mesaj/mesaj_getir.dart';
import '../../../../static/cprogram.dart';
import '../../../veli2/anasayfa/gunluk_akis/widget/akis_foto.dart';
import '../helper/handle_attachment_pressed.dart';
import '../helper/handle_message_tap.dart';
import '../helper/handle_preview_data.dart';
import '../helper/handle_send_pressed.dart';
import '../helper/load_messages.dart';
import 'helper/eski_mesajlari_yukle.dart';
import 'helper/mesaj_sil.dart';
import 'helper/mesaj_stream.dart';
import 'widget/mesaj_footer.dart';

class MesajBody extends StatefulWidget {
  COgretmen c;

  MesajBody({
    super.key,
    required this.c,
  });

  @override
  State<MesajBody> createState() => _MesajBodyState();
}

class _MesajBodyState extends State<MesajBody> {
  bool mesajListen = true;

  @override
  Widget build(BuildContext context) {
    return mesajlariYukle();
  }

  Widget mesajlariYukle() {
    return FutureBuilder(
        future: mesajGetir(
          token: cp.kullanici.token,
          gid: cp.kullanici.data.id,
          yetki: yetkiText,
          mesajEsleId: widget.c.mesajEsleId,
          page: widget.c.mesajPage.toString(),
        ),
        builder: (BuildContext context, AsyncSnapshot<ModelMesajVeliOgretmen?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return yukleniyor();
          }
          widget.c.mesajList.clear();
          widget.c.messages.clear();

          if (snapshot.data == null) {
            //mesaj yok
          } else {
            widget.c.mesajList.value = snapshot.data!.data;
            widget.c.mesajList.sort((a, b) => b.zaman.compareTo(a.zaman));

            var user;
            for (int i = 0; i < widget.c.mesajList.length; i++) {
              if (widget.c.messages.any((element) => element.id == widget.c.mesajList[i].id)) {
                continue;
              }

              if (widget.c.mesajList[i].yetki == "admin") {
                debugPrint("admin mesajı");
                user = widget.c.mesajAdmin;
              } else if (widget.c.mesajList[i].gid == widget.c.mesajGonderenId) {
                user = widget.c.mesajGonderen;
              } else if (widget.c.mesajList[i].gid == widget.c.mesajVeliId) {
                user = widget.c.mesajAlan;
              }
              if (widget.c.mesajList[i].silindi) {
                widget.c.messages.add(types.TextMessage(
                  id: widget.c.mesajList[i].id,
                  author: user,
                  text: "Bu mesaj silinmiş.",
                  metadata: {"silindi": true},
                  showStatus: true,
                  status:
                      widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                ));
              } else if (widget.c.mesajList[i].tip == TipMesaj.text) {
                widget.c.messages.add(types.TextMessage(
                  id: widget.c.mesajList[i].id,
                  author: user,
                  text: widget.c.mesajList[i].mesaj,
                  showStatus: true,
                  status:
                      widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                ));
              } else if (widget.c.mesajList[i].tip == TipMesaj.foto) {
                widget.c.messages.add(types.ImageMessage(
                  id: widget.c.mesajList[i].id,
                  author: widget.c.mesajGonderen,
                  uri: widget.c.mesajList[i].media,
                  size: 200,
                  name: "foto",
                  showStatus: true,
                  status:
                      widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                ));
              } else if (widget.c.mesajList[i].tip == TipMesaj.video) {
                widget.c.messages.add(
                  types.VideoMessage(
                    id: widget.c.mesajList[i].id,
                    author: user,
                    uri: widget.c.mesajList[i].media,
                    size: 200,
                    name: widget.c.mesajList[i].id,
                    showStatus: true,
                    status:
                        widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                  ),
                );
              } else if (widget.c.mesajList[i].tip == TipMesaj.belge) {
                widget.c.messages.add(
                  types.FileMessage(
                    id: widget.c.mesajList[i].id,
                    author: user,
                    uri: widget.c.mesajList[i].media,
                    size: 200,
                    name: "Dosya",
                    showStatus: true,
                    status:
                        widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                  ),
                );
              } else if (widget.c.mesajList[i].tip == TipMesaj.ses) {
                widget.c.messages.add(
                  types.AudioMessage(
                    duration: Duration(seconds: 60),
                    id: widget.c.mesajList[i].id,
                    author: user,
                    uri: widget.c.mesajList[i].media,
                    size: 200,
                    name: "Ses",
                    showStatus: true,
                    status:
                        widget.c.mesajList[i].goruldu ? types.Status.seen : types.Status.sent,
                  ),
                );
              }
            }
            // widget.c.messages.add(types.Message(author: types.User()))
          }

          return mesajlariGoster();
        });
  }

  Widget mesajlariGoster() {
    Get.context!.loaderOverlay.hide(); //geçici
    return Obx(
      () => Expanded(
        child: Chat(
          l10n: ChatL10nTr(),
          messages: widget.c.messages.value,
          onAttachmentPressed: handleAtachmentPressed,
          onMessageTap: handleMessageTap,
          onPreviewDataFetched: handlePreviewDataFetched,
          onEndReached: eskiMesajlariYukle,
          onMessageLongPress: (contex, message) {
            if (message.metadata?["silindi"] != null) {
              //mesaj silinmiş pencere açma
              toast(msg: "Bu mesaj silinmiş.");
              return;
            }
            mesajSil(message: message);
          },
          onSendPressed: handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: widget.c.mesajGonderen,
          customBottomWidget: mesajFooter(mesajGonder: widget.c.mesajText),
          videoMessageBuilder: (m, {messageWidth = 5}) {
            return Column(
              children: [
                Text("Video Mesaj", style: TextStyle(color: Colors.white)),
                Column(children: akisVideo(url: [m.uri], etkinlikId: "mesajvideo")),
              ],
            );
          },
          imageMessageBuilder: (m, {messageWidth = 5}) {
            return Column(
              children: [
                Text("Fotoğraf Mesaj", style: TextStyle(color: Colors.black)),
                Column(children: akisFoto(url: [m.uri])),
              ],
            );
          },
          audioMessageBuilder: (m, {messageWidth = 5}) {
            return Column(
              children: [
                Text("Ses Mesaj", style: TextStyle(color: Colors.black)),
                Column(
                    children: akisVideo(url: [m.uri], audio: true, etkinlikId: "mesajvideo")),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.c.mesajPage = 1;
    widget.c.mesajGonderen = types.User(
      id: widget.c.mesajGonderenId,
      firstName: widget.c.mesajGonderenAd,
    );
    widget.c.mesajAlan = types.User(id: widget.c.mesajVeliId, firstName: widget.c.mesajVeliAd);
    widget.c.mesajAdmin = types.User(id: "admin", firstName: "Admin");
    loadMessages();

    mesajStream().listen((event) {
      debugPrint("mesaj soruluyor"); //geçici
    });
  }

  @override
  void dispose() {
    super.dispose();
    mesajListen = false;
  }

  Stream<void> mesajStream() async* {
    while (mesajListen) {
      await Future.delayed(Duration(seconds: 4));
      if (mesajListen == false) break;
      await sonMesajGetir();
      yield null;
      //
    }
  }
}
