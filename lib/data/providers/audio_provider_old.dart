// import 'dart:io';

// import 'package:kita_muslim/data/services/storage_services.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AudioProvider {
//   final StorageServices storageService = StorageServices();

//   Future checkFolderAudios(List<String> url) async {
//     PermissionStatus status =
//         await storageService.isManageExternalStorageGranted();

//     if (status.isGranted) {
//       final myDirectory = await storageService.getAudioDirectoryPath();
//       Directory? dir;

//       if (myDirectory == null) {
//         // null
//       } else {
//         if (await myDirectory.exists()) {
//           downloadAudios(url, myDirectory.path);
//         } else {
//           dir = await myDir.create(recursive: true);
//           downloadAudios(url, dir.path);
//         }
//       }
//     } else {
//       openAppSettings();
//     }
//   }
// }
