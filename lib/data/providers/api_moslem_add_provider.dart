import 'package:dio/dio.dart';

class ApiMoslemAddProvider {
  String urlGoldPrice =
      'https://logam-mulia-api.vercel.app/prices/hargaemas-org';

  final dio = Dio();

  // dd-mm-yyyy

  Future<int> getSellPriceGold() async {
    try {
      Response response;

      response = await dio.get(
        urlGoldPrice,
      );

      int result = response.data["data"][0]["sell"] ?? 0;
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
