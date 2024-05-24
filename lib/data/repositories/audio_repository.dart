import 'package:kita_muslim/data/providers/audio_provider.dart';
import 'package:kita_muslim/data/services/dio_services.dart';

import '../others/audiomanagement.dart';

class AudioRepository {
  final audioManagement = AudioManagement();
  final audioProvider = AudioProvider();
  final dioServices = DioServices();

  Future<bool> isExistAudioFile(String fileName) {
    return audioManagement.onPressedPlayButton(fileName);
  }

  Future<List<String>> isAllAudioExist(int numberOfSurah) {
    return audioProvider.getAudioResource(numberOfSurah);
  }

  Future<Map<String, dynamic>> isExistAllAudiFiles(List<String> listAudioName) {
    return audioProvider.checkAllFileAudios(listAudioName);
  }

  Future<bool> downloadSingleAudio(String url, String dir) {
    return audioProvider.downloadSingleAudio(url, dir);
  }

  downloadBatchAudio(List<String> listUrl, String dir) {
    return audioProvider.downloadBatchAudio(listUrl, dir);
  }
}
