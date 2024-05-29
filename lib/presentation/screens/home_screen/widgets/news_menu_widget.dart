import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/blocs/article_bloc/article_bloc.dart';
import 'package:kita_muslim/data/models/article/article_muslim_model.dart';
import 'package:kita_muslim/data/providers/api_article_provider.dart';
import 'package:kita_muslim/presentation/screens/article_screen/article_detail_screen.dart';
import 'package:kita_muslim/utils/constants.dart';

class NewsMenuWidget extends StatelessWidget {
  const NewsMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.8,
      child: ListView(
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Lihat semua",
              ),
            ),
          ),
          BlocBuilder<ArticleBloc, ArticleState>(
            buildWhen: (previous, current) =>
                current is LoadingRandomArticle ||
                current is FailureRandomArticle ||
                current is SuccessRandomArticle,
            builder: (context, state) {
              if (state is LoadingRandomArticle) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is FailureRandomArticle) {
                return Center(child: Text(state.message));
              }
              if (state is SuccessRandomArticle) {
                ArticleMuslimModel articles = state.result;

                if (articles.data?.data == null) {
                  return const Center(
                    child: Text("Tidak ada data"),
                  );
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.sizeOf(context).height / 5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 3000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {},
                    scrollDirection: Axis.horizontal,
                  ),
                  items: articles.data!.data!.map((e) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            context.read<ArticleBloc>().add(
                                GetDetailArticleEvent(articleId: e.id ?? ""));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ArticleDetailScreen(),
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: e.thumbnail ??
                                          Constants.urlImageNotFound,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10.0,
                                    left: 8.0,
                                    right: 8.0,
                                    child: Text(
                                      e.title ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.sizeOf(context).width /
                                                25,
                                        color: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            115, 54, 43, 43),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
