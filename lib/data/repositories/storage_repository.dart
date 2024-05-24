import 'dart:io';

import 'package:kita_muslim/data/providers/storage_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageRepository {
  final storageProvider = StorageProvider();

  Future<PermissionStatus> isManageExternalStorageGranted() async {
    return storageProvider.isManageExternalStorageGranted();
  }

  Future<PermissionStatus> isStorageGranted() async {
    return storageProvider.isStorageGranted();
  }

  Future<Directory> getAudioDirectoryPath() async {
    return await storageProvider.getAudioDirectoryPath();
  }
}
