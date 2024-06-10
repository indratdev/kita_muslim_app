import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

class AudioManagement {
  final audioPlayer = AudioPlayer();
  String fileName;

  AudioManagement({
    this.fileName = "",
  });

  // Future<bool> onPressedPlayButton(String fileName) async {
  //   bool result = false;
  //   try {
  //     String textasset =
  //         "assets/audios/$fileName.mp3"; //path to text file asset
  //     ByteData  text = await rootBundle.load(textasset);

  //     if (text != "") {
  //       result = true;
  //     } else {
  //       result = false;
  //     }
  //   } catch (e) {
  //     result = false;
  //   }
  //   return result;
  // }

  /// new version
  Future<bool> checkAudioFileExist(String fileName) async {
    bool result = false;
    try {
      String audioAssetPath = "assets/audios/$fileName.mp3";
      ByteData audioData = await rootBundle.load(audioAssetPath);

      if (audioData.lengthInBytes > 0) {
        result = true;
      } else {
        result = false;
      }
    } catch (e) {
      // If an error occurs (e.g., file not found), result will be false
      result = false;
    }
    return result;
  }
}
