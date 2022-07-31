import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/widgets/custom_text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConformScreen extends StatefulWidget {
  const ConformScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  final File videoFile;
  final String videoPath;

  @override
  State<ConformScreen> createState() => _ConformScreenState();
}

class _ConformScreenState extends State<ConformScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });

    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: Get.width,
              height: Get.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: Get.width - 20,
                    child: CustomTextInputField(
                      controller: songController,
                      labelText: "Song Name",
                      icon: Icons.music_note,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: Get.width - 20,
                    child: CustomTextInputField(
                      controller: captionController,
                      labelText: "Caption",
                      icon: Icons.closed_caption,
                      isObscure: false,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Share",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
