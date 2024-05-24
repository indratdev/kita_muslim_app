import 'dart:developer';

import 'package:dio/dio.dart';

class DioServices {
  static Dio dio = Dio();

  static bool downloadSingleFile(String urlVideo, String savePath) {
    bool result = false;
    try {
      dio.download(
        urlVideo.toString(),
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      result = true;
      return result;
    } catch (e) {
      log(e.toString());
      return result;
    }
  }
}
