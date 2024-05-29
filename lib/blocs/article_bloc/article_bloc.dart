import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/repositories/article_repository.dart';

import '../../data/models/article/article_muslim_model.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final articleRepository = ArticleRepository();

  ArticleBloc() : super(ArticleInitial()) {
    on<GetRandomArticleEvent>((event, emit) async {
      emit(LoadingRandomArticle());
      try {
        ArticleMuslimModel articles =
            await articleRepository.getRandomArticle();
        emit(SuccessRandomArticle(result: articles));
      } catch (e) {
        emit(FailureRandomArticle(message: e.toString()));
      }
    });
  }
}
