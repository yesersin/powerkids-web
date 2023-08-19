import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../const/yetki_text.dart';
import '../../../../../helper/video_kaydet.dart';
import '../../../../../service/gunluk_akis/gunluk_akis_update.dart';
import '../../../../../static/cogretmen.dart';
import '../../../../../static/cprogram.dart';
import '../../../../../static/yetki.dart';

late VideoPlayerController _videoPlayerController;
late CustomVideoPlayerController _customVideoPlayerController;

List<Widget> akisVideo(
    {required List<String> url, bool audio = false, required String etkinlikId}) {
  return [
    InkWell(
        onTap: () async {
          if (yetkiText == YetkiText.veli && etkinlikId != "mesajvideo") {
            updateBegenGorulduGunlukAkis(
                //geçici, görüldü düzenlemesi
                token: cp.kullanici.token,
                body: {"gordu": cp.kullanici.data.adSoyad},
                id: etkinlikId);
          }

          if (audio) {
            FlutterSoundPlayer? mp = FlutterSoundPlayer();
            await mp.openPlayer();
            await mp.startPlayer(fromURI: url.first);
            await showDialog(
                context: Get.context!,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await mp.closePlayer();
                              await mp.openPlayer();
                              mp.startPlayer(fromURI: url.first);
                            },
                            icon: Icon(Icons.play_arrow)),
                        IconButton(
                            onPressed: () async {
                              await mp.closePlayer();
                            },
                            icon: Icon(Icons.stop)),
                      ],
                    ),
                  );
                });
            mp.closePlayer();
            return;
          }
          Get.context!.loaderOverlay.show();

          try {
            _videoPlayerController = VideoPlayerController.network(url.first);
            await _videoPlayerController.initialize();
            _customVideoPlayerController = CustomVideoPlayerController(
              context: Get.context!,
              videoPlayerController: _videoPlayerController,
              customVideoPlayerSettings: CustomVideoPlayerSettings(
                  controlBarAvailable: true,
                  settingsButton: IconButton(
                    onPressed: () {
                      videoKaydet(url.first);
                    },
                    icon: IconButton(
                      onPressed: () {
                        videoKaydet(url.first);
                      },
                      icon: Obx(
                        () => (co.video.value == 0)
                            ? Icon(Icons.download)
                            : Text(
                                co.video.value.toString(),
                                style: const TextStyle(fontSize: 13),
                              ),
                      ),
                    ),
                  )),
            );
          } catch (e) {
            toast(msg: "Video oynatılırken bir hata oldu:" + e.toString());
            Get.context!.loaderOverlay.hide();
            return;
          }

          Get.context!.loaderOverlay.hide();
          await showDialog(
              context: Get.context!,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.all(10),
                  content: InkWell(
                    onTap: () {},
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: CustomVideoPlayer(
                          customVideoPlayerController: _customVideoPlayerController),
                    ),
                  ),
                );
              });
          _videoPlayerController.dispose();
        },
        child: SizedBox(
          width: Get.width - 50,
          height: audio ? 40 : 120,
          child: Icon(
            audio ? Icons.multitrack_audio_sharp : Icons.video_collection_rounded,
            size: audio ? 25 : 100,
          ),
        ))
  ];
}
