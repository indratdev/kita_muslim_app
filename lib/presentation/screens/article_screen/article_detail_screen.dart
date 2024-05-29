import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kita_muslim/blocs/article_bloc/article_bloc.dart';

import '../../../data/models/article/article_muslim_model.dart';
import '../../../utils/constants.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Artikel"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<ArticleBloc, ArticleState>(
            buildWhen: (previous, current) =>
                current is LoadingDetailArticle ||
                current is FailureDetailArticle ||
                current is SuccessDetailArticle,
            builder: (context, state) {
              if (state is LoadingDetailArticle) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is FailureDetailArticle) {
                return Center(child: Text(state.message));
              }
              if (state is SuccessDetailArticle) {
                Datum article = state.result;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 2.6,
                        width: MediaQuery.sizeOf(context).width - 20,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: const BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              article.thumbnail ?? Constants.urlImageNotFound,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      article.title ?? "",
                      style: TextStyle(
                        fontSize: MediaQuery.sizeOf(context).width / 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                        "${article.author ?? ""} | ${article.date} | ${article.type}"),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tags",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                                article.categories?.length ?? 0, (index) {
                              Map<String, dynamic> tagArticle =
                                  article.categories?[index];
                              Color tagColor = Constants.tagColors[
                                  index % Constants.tagColors.length];
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: tagColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(tagArticle["name"]),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    HtmlWidget(
                      article.content_html ?? "",
                      onLoadingBuilder: (context, element, loadingProgress) {
                        return CircularProgressIndicator.adaptive(
                            value: loadingProgress);
                      },
                      onErrorBuilder: (context, element, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
