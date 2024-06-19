import 'package:flutter/material.dart';

import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/export.dart';

import '../../../utils/constants.dart';
import '../../widgets/customwidgets.dart';

class HomeScreenV2 extends StatelessWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor.withOpacity(.9),
      appBar: CustomWidgets.basicAppBar(
        Constants.appName,
        listAction: <Widget>[
          IconButton(
            onPressed: () {
              CustomWidgets.showDialogAppInfo(context);
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height / 2.6),
              Positioned(
                bottom: 30,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.sizeOf(context).height / 2.6,
                  child: SizedBox(
                    child: BlocBuilder<PrayerBloc, PrayerState>(
                      buildWhen: (previous, current) =>
                          current is LoadingRandomWallpaper ||
                          current is FailureRandomWallpaper ||
                          current is SuccessRandomWallpaper,
                      builder: (context, state) {
                        if (state is LoadingRandomWallpaper) {
                          return CustomWidgets
                              .showLoadingIndicatorWithContainer(
                                  context,
                                  MediaQuery.sizeOf(context).height / 2.8,
                                  MediaQuery.sizeOf(context).width);
                        }
                        if (state is FailureRandomWallpaper) {
                          return Image.network(
                              "https://gratisography.com/wp-content/uploads/2024/03/gratisography-funflower-800x525.jpg",
                              fit: BoxFit.cover);
                        }
                        if (state is SuccessRandomWallpaper) {
                          return Image.network(
                            state.urlImage,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const InfoBannerWidget(),
            ],
          ),
          // 2
          const MainMenuWidget(),
          const NewsMenuWidget()
        ],
      ),
    );
  }
}
