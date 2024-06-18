import 'dart:developer';

import 'package:dio/dio.dart';

class DioServices {
  static Dio dio = Dio();

  // static bool downloadSingleFile(String urlVideo, String savePath) {
  //   print(">>> downloadSingleFile run");
  //   bool result = false;
  //   try {
  //     dio
  //         .download(
  //       urlVideo.toString(),
  //       savePath,
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         sendTimeout: const Duration(seconds: 30), // 10 seconds
  //         receiveTimeout: const Duration(seconds: 30), // 10 seconds
  //       ),
  //     )
  //         .whenComplete(
  //       () {
  //         print(">>> download completed : ${urlVideo.toString()}");
  //       },
  //     );
  //     result = true;
  //     return result;
  //   } catch (e) {
  //     log(e.toString());
  //     return result;
  //   }
  // }

  // static Future<bool> downloadSingleFile(String urlVideo, String savePath,
  //     Function(int, int) onReceiveProgress) async {
  //   print(">>> downloadSingleFile run");
  //   bool result = false;
  //   try {
  //     await dio.download(
  //       urlVideo,
  //       savePath,
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         sendTimeout: const Duration(seconds: 30),
  //         receiveTimeout: const Duration(seconds: 30),
  //       ),
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     print(">>> download completed : $urlVideo");
  //     result = true;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return result;
  // }

  // static Future<bool> downloadSingleFile(String urlVideo, String savePath,
  //     Function(int, int) onReceiveProgress) async {
  static Future<bool> downloadSingleFile(
    String urlVideo,
    String savePath,
  ) async {
    print(">>> downloadSingleFile run");
    bool result = false;
    try {
      await dio.download(
        urlVideo,
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
        // onReceiveProgress: onReceiveProgress,
      );
      print(">>> download completed : $urlVideo");
      result = true;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }
}
