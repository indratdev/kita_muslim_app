import 'dart:developer';
import 'dart:io';

import 'package:kita_muslim/data/providers/api_surah_provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/dio_services.dart';

class MyDownloadableItem {
  String name = "";
}

class AudioProvider {
  final apiProvider = ApiSurahProvider();
  final directoryName = "audios";

  Future checkFolderAudios(List<String> url) async {
    var status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      // Directory
      Directory? baseStorage = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationSupportDirectory();

      /// buat folder
      const directoryName = "audios";
      final myDir = Directory("${baseStorage!.path}/$directoryName");

      Directory? dir;

      if (await myDir.exists()) {
        dir = myDir;
        downloadAudios(url, dir.path);
      } else {
        dir = await myDir.create(recursive: true);
        downloadAudios(url, dir.path);
      }
    } else {
      openAppSettings();
    }
  }

  Future<void> downloadAudios(List<String> url, String dir) async {
    int countFileHasDownloded = 0;

    for (var urlVideo in url) {
      // get name video (replace string to get only name audio)
      String audioName = urlVideo.substring(55).replaceAll(".mp3", "");
      // check files audio already downloaded ?
      var isFileAudios = await checkFileAudios(audioName);

      var savePath = "$dir/$audioName.mp3";
      if (!isFileAudios) {
        // -------- new
        bool statusDownload =
            DioServices.downloadSingleFile(urlVideo, savePath);

        (statusDownload) ? countFileHasDownloded += 1 : countFileHasDownloded;
      } else {}
    }
  }

  Future<bool> downloadSingleAudio(String url, String dir) async {
    bool status = false;

    //new
    int countFileHasDownloded = 0;

    // get name video (replace string to get only name audio)
    String audioName = url.substring(55).replaceAll(".mp3", "");
    // check files audio already downloaded ?
    var isFileAudios = await checkFileAudios(audioName);
    var savePath = "$dir/$audioName.mp3";
    if (!isFileAudios) {
      bool statusDownload = DioServices.downloadSingleFile(url, savePath);

      (statusDownload) ? countFileHasDownloded += 1 : countFileHasDownloded;
    } else {
      // if file audio exist
      status = false;
    }

    return status;
  }

  Future<bool> downloadBatchAudio(List<String> listUrl, String dir) async {
    bool status = false;
    //new

    for (var url in listUrl) {
      // get name video (replace string to get only name audio)
      String audioName = url.substring(55).replaceAll(".mp3", "");
      // check files audio already downloaded ?
      var isFileAudios = await checkFileAudios(audioName);
      var savePath = "$dir/$audioName.mp3";
      if (!isFileAudios) {
        // bool statusDownload =
        DioServices.downloadSingleFile(url, savePath);
      }

      status = true;
    }

    return status;
  }

  Future<bool> checkFileAudios(String nameFile) async {
    try {
      // var baseStorage = await getExternalStorageDirectory();
      Directory? baseStorage = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationSupportDirectory();
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      var fullStringPath = "${myDir.path}$nameFile.mp3";
      var result = await File(fullStringPath).exists();

      return result;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String> getAudioFileLocation(String audioFileName) async {
    String resultAudio = "";
    try {
      Directory? baseStorage = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationSupportDirectory();

      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      resultAudio = "${myDir.path}$audioFileName.mp3";
      return resultAudio;
    } catch (e) {
      return "";
    }
  }

  Future<Map<String, dynamic>> checkAllFileAudios(List<String> allAudio) async {
    Map<String, dynamic> result = <String, dynamic>{};
    List<bool> allExist = [];
    List<String> filenameAudio = [];

    for (var data in allAudio) {
      String audioName = data.substring(55).replaceAll(".mp3", "");
      var resultLocation = await getAudioFileLocation(audioName);
      if (resultLocation != "") {
        filenameAudio.add(resultLocation);
      }

      // check files audio already downloaded ?
      allExist.add(await checkFileAudios(audioName));
    }

    // kalau list mengandung false -> berarti harus download (ada file yang
    // tidak terdownload semua
    var resultAudioExist = allExist.contains(false);
    result["audioStatus"] = resultAudioExist;
    result["listAudio"] = allAudio;
    result["fileNameAudio"] = filenameAudio;
    return result;
  }

  Future<List<String>> getAudioResource(int number) async {
    var result = await apiProvider.getDetailSurah(number);
    List<String> urlAudio = [];

    for (var data in result.data.verses) {
      urlAudio.add(data.audio.secondary[0].toString());
    }

    return urlAudio;
  }
}
