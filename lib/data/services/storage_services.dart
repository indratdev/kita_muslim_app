// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class StorageServices {
//   final String _audioDirectoryName = "audios";

//   String get getAudioDirectoryName {
//     return _audioDirectoryName;
//   }

//   Future<PermissionStatus> isManageExternalStorageGranted() async {
//     return await Permission.manageExternalStorage.request();
//   }

//   Future<Directory?> getBaseStorage() async {
//     return Platform.isAndroid
//         ? await getExternalStorageDirectory()
//         : await getApplicationSupportDirectory();
//   }

//   Future<Directory?> getAudioDirectoryPath() async {
//     Directory? baseStorage = await getBaseStorage();
//     return Directory("${baseStorage!.path}/$_audioDirectoryName");
//   }

//   Future<bool> checkFileAudios(String nameFile) async {
//     try {
//       final myDir = await getAudioDirectoryPath();
//       var fullStringPath = "${myDir!.path}$nameFile.mp3";
//       return await File(fullStringPath).exists();
//     } catch (e) {
//       return false;
//     }
//   }
// }
