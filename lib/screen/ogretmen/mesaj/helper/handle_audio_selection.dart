import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:com.powerkidsx/component/pencere/uyari_pencere.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../helper/toast.dart';
import '../../../../static/cogretmen.dart';
import 'mesaj_ekle.dart';

void handleAudioSelection() async {
  Pencere().ac(content: SesKaydetPencere(), context: Get.context!);
}

class SesKaydetPencere extends StatefulWidget {
  const SesKaydetPencere({Key? key}) : super(key: key);

  @override
  State<SesKaydetPencere> createState() => _SesKaydetPencereState();
}

const theSource = AudioSource.microphone;

typedef _Fn = void Function();

class _SesKaydetPencereState extends State<SesKaydetPencere> {
  //8mb sınır
  Codec _codec = Codec.defaultCodec;
  String dosyaIsim = "record" + Random().nextInt(5000000).toString() + ".mp4";
  String path = "";
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();

  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  void initState() {
    super.initState();
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (!(status == PermissionStatus.granted || status == PermissionStatus.limited)) {
        toast(msg: "Mikrofon izni alınamadı!");
        return;
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      dosyaIsim = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth |
          AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    path = "";
    _mRecorder!
        .startRecorder(
      toFile: dosyaIsim,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        if (value == null) {
          toast(msg: "Ses kayıtta hata oluştu.");
          return;
        }
        path = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(
        _mPlayerIsInited && _mplaybackReady && _mRecorder!.isStopped && _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: dosyaIsim,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(3),
          height: 80,
          width: double.infinity,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   color: Color(0xFFFAF0E6),
          //   border: Border.all(
          //     color: Colors.indigo,
          //     // width: 1,
          //   ),
          // ),

          child: Row(children: [
            ElevatedButton(
              onPressed: getRecorderFn(),
              //color: Colors.white,
              //disabledColor: Colors.grey,
              child: _mRecorder!.isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic),
              // child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
            ),
            SizedBox(
              width: 20,
            ),
            Text(_mRecorder!.isRecording ? 'Ses Kayıt' : 'Ses kayıt için basın'),
          ]),
        ),
        Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(3),
          height: 80,
          width: double.infinity,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   color: Color(0xFFFAF0E6),
          //   border: Border.all(
          //     color: Colors.indigo,
          //     width: 3,
          //   ),
          // ),
          child: Row(children: [
            ElevatedButton(
              onPressed: getPlaybackFn(),
              //color: Colors.white,
              //disabledColor: Colors.grey,
              child: _mRecorder!.isRecording
                  ? const Icon(Icons.stop)
                  : const Icon(Icons.play_arrow),
              // child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
            ),
            SizedBox(
              width: 20,
            ),
            Text(_mPlayer!.isPlaying ? 'Ses çalıyor' : ""),
            // Text(_mPlayer!.isPlaying ? 'Ses çalınıyor' : 'Player is stopped'),
          ]),
        ),
        gonderBtn(),
      ],
    );
  }

  MaterialButton gonderBtn() {
    return MaterialButton(
        color: path.isNotEmpty ? Colors.green : Colors.grey,
        onPressed: () async {
          File file = File(path);
          int size = await file.length();
          PlatformFile secilenImaj =
              PlatformFile(name: dosyaIsim, size: size, path: file.path);
          // debugPrint(secilenImaj.toString());
          // return;
          if (co.mesajText.text.isEmpty) co.mesajText.text = "ses";
          mesajEkle(
              c: co,
              tip: "ses",
              mesajEsleId: co.mesajEsleId,
              type: types.MessageType.audio,
              file: secilenImaj,
              mesajGonder: co.mesajText);
        },
        child: Text("Gönder"));
  }
}
