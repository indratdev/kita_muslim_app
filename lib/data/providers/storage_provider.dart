import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageProvider {
  final String _audioDirectoryName = "audios";

  String get getAudioDirectoryName {
    return _audioDirectoryName;
  }

  Future<PermissionStatus> isManageExternalStorageGranted() async {
    return await Permission.manageExternalStorage.request();
  }

  Future<PermissionStatus> isStorageGranted() async {
    return await Permission.storage.request();
  }

  Future<Directory?> getBaseStorage() async {
    return Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
  }

  Future<Directory> getAudioDirectoryPath() async {
    Directory? baseStorage = await getBaseStorage();
    Directory directory =
        Directory("${baseStorage!.path}/$_audioDirectoryName");
    bool isDirectoryExist = await directory.exists();

    if (!isDirectoryExist) {
      directory.createSync();
    }

    return directory;

    // return Directory("${baseStorage!.path}/$_audioDirectoryName");
  }

  Future<bool> checkFileAudios(String nameFile) async {
    try {
      final myDir = await getAudioDirectoryPath();
      var fullStringPath = "${myDir!.path}$nameFile.mp3";
      return await File(fullStringPath).exists();
    } catch (e) {
      return false;
    }
  }
}
