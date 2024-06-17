import 'package:kita_muslim/data/providers/audio_provider.dart';
import 'package:kita_muslim/data/services/dio_services.dart';

import '../others/audiomanagement.dart';

class AudioRepository {
  final audioManagement = AudioManagement();
  final audioProvider = AudioProvider();
  final dioServices = DioServices();

  Future<bool> isExistAudioFile(String fileName) {
    return audioManagement.checkAudioFileExist(fileName);
  }

  Future<List<String>> isAllAudioExist(String numberOfSurah) {
    return audioProvider.getAudioResource(numberOfSurah);
  }

  Future<Map<String, dynamic>> isExistAllAudiFiles(List<String> listAudioName) {
    return audioProvider.checkAllFileAudios(listAudioName);
  }

  isAllAudioAlreadyDownloaded(int startNumber, int endNumber) async {
    List<bool> result = [];

    // for (var audioDetail in listAudioNumber) {
    //   bool status = await audioManagement.checkAudioFileExist(audioDetail);
    //   result.add(status);
    // }

    for (int i = startNumber; i <= endNumber; i++) {
      bool status = await audioManagement.checkAudioFileExist(i.toString());
      result.add(status);
    }

    if (result.contains(false)) {
      print("ada yang kosong");
    }
  }

  Future<bool> downloadSingleAudio(String url, String dir) {
    return audioProvider.downloadSingleAudio(url, dir);
  }

  downloadBatchAudio(
    List<String> listUrl,
    String dir,
    dynamic Function(double) onProgress,
  ) {
    return audioProvider.downloadBatchAudio(listUrl, dir, onProgress);
  }
}
