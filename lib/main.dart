import 'package:flutter/material.dart';

import 'package:kita_muslim/config/routes.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'blocs/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SurahBloc(),
        ),
        BlocProvider(
          create: (context) => AudiomanagementBloc(),
        ),
        BlocProvider(
          create: (context) => HadistsBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => PrayerBloc(),
        ),
        BlocProvider(
          create: (context) => CalculatorBloc(),
        ),
        BlocProvider(
          create: (context) => ArticleBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Constants.deepGreenColor,
            centerTitle: true,
            actionsIconTheme: IconThemeData(
              color: Constants.greyColor,
            ),
            iconTheme: IconThemeData(
              color: Constants.greyColor,
            ),
          ),
        ),
        initialRoute: '/splash',
        routes: Routes().getRoutes,
      ),
    );
  }
}
