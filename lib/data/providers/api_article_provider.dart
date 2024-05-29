import 'package:dio/dio.dart';
import 'package:kita_muslim/data/models/article/article_muslim_model.dart';

class ApiArticleProvider {
  String muslimorid =
      'https://artikel-islam.netlify.app/.netlify/functions/api/ms';

  final dio = Dio();

  Future<ArticleMuslimModel> getRandomArticle() async {
    try {
      Response response;
      String url = muslimorid;

      Map<String, dynamic> params = {
        'page': 1,
        // 's': "Tata cara sholat", // "s" for searching query
      };

      response = await dio.get(
        url,
        queryParameters: params,
      );

      return ArticleMuslimModel.fromJson(response.data);
    } catch (e) {
      // return null;
      print(e.toString());
      throw e.toString();
    }
  }
}
