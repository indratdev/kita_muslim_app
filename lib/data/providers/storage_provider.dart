import 'dart:developer';
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
    try {
      final Directory? directory = await getBaseStorage();
      final path = '${directory?.path}/$_audioDirectoryName';
      final newDirectory = Directory(path);

      if (!newDirectory.existsSync()) {
        newDirectory.createSync(recursive: true);
        log('Folder created: $path');
      } else {
        log('Folder already exists: $path');
      }
      return newDirectory;
    } catch (e) {
      log('Error creating folder: $e');
      rethrow;
    }
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

  Future<Directory> getAudioDirectoryPathNew() async {
    try {
      // Request storage permissions
      if (await Permission.storage.request().isGranted) {
        print('Storage permission granted.');
      } else if (await Permission.manageExternalStorage.request().isGranted) {
        print('Manage external storage permission granted.');
      } else {
        throw Exception('Storage permission not granted');
      }

      // Get the base storage directory
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception('Unable to get the external storage directory');
      }

      // Construct the new directory path
      final path = '${directory.path}/MyAudioDirectory';
      final newDirectory = Directory(path);

      // Print the new directory path (for debugging purposes)
      print(">>> newDirectory : ${newDirectory.path}");

      // Check if the directory exists and create it if it doesn't
      if (!await newDirectory.exists()) {
        await newDirectory.create(recursive: true);
        log('Folder created: $path');
      } else {
        log('Folder already exists: $path');
      }

      return newDirectory;
    } catch (e) {
      log('Error creating folder: $e');
      rethrow;
    }
  }

  Future<List<FileSystemEntity>> listFilesInDirectoryNew() async {
    try {
      const path =
          '/storage/emulated/0/Android/data/com.indratdev.kitamuslim/files/audios/';
      final newDirectory = Directory(path);
      if (await newDirectory.exists()) {
        List<FileSystemEntity> files = newDirectory.listSync();
        return files;
      } else {
        throw Exception('Directory does not exist');
      }
    } catch (e) {
      log('Error listing files: $e');
      rethrow;
    }
  }
}
