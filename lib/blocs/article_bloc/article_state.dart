part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

final class ArticleInitial extends ArticleState {}

class FailureArticle extends ArticleState {
  String message;

  FailureArticle({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class FailureRandomArticle extends FailureArticle {
  FailureRandomArticle({required super.message});
}

class LoadingRandomArticle extends ArticleState {}

class SuccessRandomArticle extends ArticleState {
  ArticleMuslimModel result;

  SuccessRandomArticle({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
