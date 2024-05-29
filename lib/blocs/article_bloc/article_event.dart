part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class GetRandomArticleEvent extends ArticleEvent {}

class GetDetailArticleEvent extends ArticleEvent {
  String articleId;

  GetDetailArticleEvent({
    required this.articleId,
  });
}
