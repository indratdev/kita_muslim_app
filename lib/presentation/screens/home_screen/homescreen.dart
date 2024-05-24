import 'package:flutter/material.dart';
import 'package:kita_muslim/config/routes.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/presentation/screens/home_screen/homewidgets.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(Constants.appName, <Widget>[
        IconButton(
          onPressed: () {
            CustomWidgets.showDialogAppInfo(context);
          },
          icon: const Icon(Icons.info),
        ),
      ]),
      body: Container(
        decoration: CustomWidgets.decorationBasicUI(),
        child: GridView.count(
          primary: false,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.readAlquran);
                BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
              },
              child: HomeWidgets.showHomeMenuItem(
                  Constants.quranImage, "Al-Qur'an"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.dailyPrayer);
                BlocProvider.of<SurahBloc>(context).add(GetAllSurahHarian());
              },
              child: HomeWidgets.showHomeMenuItem(
                  Constants.dailyPrayerImage, "Doa Sehari-hari"),
            ),
            // favorite menu
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.favoriteSurah);
                context
                    .read<FavoriteBloc>()
                    .add(GetListAllSurahFavoriteEvent());
              },
              child: HomeWidgets.showHomeMenuItem(
                  Constants.favoriteImage, "Favorit"),
            ),
            // hadists menu
            InkWell(
              onTap: () {
                context.read<HadistsBloc>().add(GetListBookHadists());
                Navigator.pushNamed(context, Routes.hadists);
              },
              child:
                  HomeWidgets.
                  showHomeMenuItem
                  (Constants.hadistImage, "Hadist"),
            ),
          ],
        ),
      ),
    );
  }
}
