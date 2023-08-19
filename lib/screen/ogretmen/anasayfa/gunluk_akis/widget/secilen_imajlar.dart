import 'dart:io';

import 'package:com.powerkidsx/controller/ogretmen/c_ogretmen.dart';
import 'package:com.powerkidsx/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

Widget secilenImajlar({required COgretmen c, required bool fotograf}) {
  return Container(
    height: Get.height * 0.3,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Obx(() {
      if (c.akisSecilenDosyalar.length == 0) {
        return Container(
          height: Get.height * 0.3,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(fotograf ? "Lütfen fotoğraf seçiniz." : "Lütfen video seçiniz."),
          ),
        );
      }
      if (fotograf) {
        return Container(
          height: 200,
          width: Get.width,
          child: Obx(
            () => GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: c.akisSecilenDosyalar.length,
                itemBuilder: (BuildContext context, int index) {
                  final fileBytes = c.akisSecilenDosyalar[index].bytes;
                  final fileName = c.akisSecilenDosyalar[index].name;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Image.memory(
                          c.akisSecilenDosyalar[index].bytes!,
                          height: 175,
                          width: 175,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: InkWell(
                          onTap: () {
                            c.akisSecilenDosyalar.removeAt(index);
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 2,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration:
                              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Text((index + 1).toString(), style: TextStyle()),
                        ),
                      ),
                    ],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                )),
          ),
        );
      } else {
        return Container(
          height: 160,
          width: Get.width,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: c.akisSecilenDosyalar.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    late VideoPlayerController controller;
                    controller = VideoPlayerController.file(
                        File(c.akisSecilenDosyalar.first.path!),
                        videoPlayerOptions:
                            VideoPlayerOptions(allowBackgroundPlayback: false));
                    try {
                      await controller.initialize();

                      bool play = false;
                      await showDialog(
                          context: Get.context!,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              insetPadding: EdgeInsets.zero,
                              content: InkWell(
                                onTap: () {
                                  if (play == false) {
                                    controller.play();
                                    play = true;
                                  } else {
                                    controller.pause();
                                    play = false;
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: VideoPlayer(controller),
                                    ),
                                    VideoProgressIndicator(controller, allowScrubbing: true),
                                  ],
                                ),
                              ),
                            );
                          });
                      controller.dispose();
                    } catch (e) {
                      toast(msg: "Hata:" + e.toString());
                    }
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.video_collection_rounded,
                          size: 150,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: InkWell(
                          onTap: () {
                            c.akisSecilenDosyalar.removeAt(index);
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    }),
  );
}
