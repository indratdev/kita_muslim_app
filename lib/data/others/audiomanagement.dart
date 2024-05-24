import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

class AudioManagement {
  final audioPlayer = AudioPlayer();
  String fileName;

  AudioManagement({
    this.fileName = "",
  });

  Future<bool> onPressedPlayButton(String fileName) async {
    bool result = false;
    try {
      String textasset =
          "assets/audios/$fileName.mp3"; //path to text file asset
      var text = await rootBundle.load(textasset);

      if (text != "") {
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }
}
