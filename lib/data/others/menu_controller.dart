import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/presentation/screens/home_screen/homescreen.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../blocs/export.dart';
import '../../config/routes.dart';

class MenuModel {
  MenuModel({
    required this.menuIcon,
    required this.menuName,
    required this.menuRoute,
  });

  String menuIcon;
  String menuName;
  Function(BuildContext)? menuRoute;

  factory MenuModel.fromJson(String str) => MenuModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuModel.fromMap(Map<String, dynamic> json) => MenuModel(
        menuIcon: json["menuIcon"],
        menuName: json["menuName"],
        menuRoute: json["menuRoute"],
      );

  Map<String, dynamic> toMap() => {
        "menuIcon": menuIcon,
        "menuName": menuName,
        "menuRoute": menuRoute,
      };
}

class MenusController {
  List<MenuModel> menus = [
    MenuModel(
      menuIcon: Constants.quranV2Icon,
      menuName: "Al-Qur'an",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.readAlquran);
        BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
      },
    ),
    MenuModel(
      menuIcon: Constants.readQuranIcon,
      menuName: "Doa Sehari-hari",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.dailyPrayer);
        BlocProvider.of<SurahBloc>(context).add(GetAllSurahHarian());
      },
    ),
    MenuModel(
      menuIcon: Constants.shalatIcon,
      menuName: "Jadwal Shalat",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.prayerSchedule);
        BlocProvider.of<PrayerBloc>(context).add(NextPrayerTimeEvent());
        BlocProvider.of<PrayerBloc>(context).add(GetPrayerTimeEvent());
      },
    ),
    MenuModel(
      menuIcon: Constants.qiblaIcon,
      menuName: "Arah Kiblat",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.qiblahScreen);
      },
    ),
    MenuModel(
      menuIcon: Constants.calculatorIcon,
      menuName: "Kalkulator",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.calculatorScreen);
      },
    ),
    MenuModel(
      menuIcon: Constants.favoriteImage,
      menuName: "Favorit",
      menuRoute: (context) {
        Navigator.of(context).pushNamed(Routes.favoriteSurah);
        context.read<FavoriteBloc>().add(GetListAllSurahFavoriteEvent());
      },
    ),
    MenuModel(
      menuIcon: (Constants.hadistImage),
      menuName: "Hadist",
      menuRoute: (context) {
        context.read<HadistsBloc>().add(GetListBookHadists());
        Navigator.pushNamed(context, Routes.hadists);
      },
    ),
    // MenuModel(
    //   menuIcon: (Constants.hadistImage),
    //   menuName: "Artikel ",
    //   menuRoute: (context) {
    //     Navigator.pushNamed(context, Routes.articleScreen);
    //     // context.read<HadistsBloc>().add(GetListBookHadists());
    //   },
    // ),
    MenuModel(
      menuIcon: Constants.allIcon,
      menuName: "Semua",
      menuRoute: (context) {},
    ),
  ];

  List<MenuModel> get getListmenuPacket => menus;
}
