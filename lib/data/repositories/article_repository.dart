import 'package:kita_muslim/data/providers/api_article_provider.dart';

import '../models/article/article_muslim_model.dart';

class ArticleRepository {
  final apiArticleProvider = ApiArticleProvider();

  Future<ArticleMuslimModel> getRandomArticle() async {
    return await apiArticleProvider.getRandomArticle();
  }

  Future<Datum> getDetailArticle(String id) async {
    return await apiArticleProvider.getDetailArticle(id);
  }
}
