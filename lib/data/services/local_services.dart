import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  AndroidDeviceInfo? androidDeviceInfo;
  String? release;
  int? sdkInt;
  String? manufacturer;
  String? model;
  IosDeviceInfo? iosDeviceInfo;
  String? systemName, version, name;

  DeviceInfo({
    this.androidDeviceInfo,
    this.manufacturer,
    this.model,
    this.release,
    this.sdkInt,
    this.iosDeviceInfo,
    this.name,
    this.systemName,
    this.version,
  });
}

class LocalServices {
  Future<DeviceInfo> checkDeviceInfo() async {
    // Map<String, dynamic> deviceInfo = {};
    DeviceInfo deviceInfo = DeviceInfo();

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      // print('Android $release (SDK $sdkInt), $manufacturer $model');

      // Android 9 (SDK 28), Xiaomi Redmi Note 7
      deviceInfo.androidDeviceInfo = androidInfo;
      deviceInfo.release = release;
      deviceInfo.sdkInt = sdkInt;
      deviceInfo.manufacturer = manufacturer;
      deviceInfo.model = model;
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      // print('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone

      deviceInfo.iosDeviceInfo = iosInfo;
      deviceInfo.systemName = systemName;
      deviceInfo.version = version;
      deviceInfo.name = name;
      deviceInfo.model = model;
    }

    return deviceInfo;
  }
}
