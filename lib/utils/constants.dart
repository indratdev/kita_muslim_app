import 'package:flutter/material.dart';

class Constants {
  static const color1 = Color(0xFF3B2D60);
  static const color2 = Color(0xFFE78DD2);
  static const color3 = Color(0xFFDFB59C);
  static const iblueLight = Color(0xFFDDE6FF);
  static const iwhite = Color(0xFFFEFEFE);
  static const igreen = Color(0xFF377D71);

  static const colorBlack = Color(0xFF100F0F);
  static const colorGreenDeep = Color(0xFF0F3D3E);
  static const colorCream = Color(0xFFE2DCC8);
  static const colorWhite = Color(0xFFF1F1F1);

  static const iFebruaryInk1 = Color(0xFFADCCEF);
  static const iFebruaryInk2 = Color(0xFFE7F0FD);

  /// new color
  static const lightGreenColor = Color(0xFFd5f3d1);

  static const appName = 'Kita Muslim';
  static const appWallpaper = "assets/images/wallpaper.png";
  static const textQuran = "Qur'an";
  static const appVersion = "v.1.1.0";
  static const appDevEmail = "indrat.dev@gmail.com";
  static const clientIdUnsplash = "LbvlfhTLNsdV4qp5Rsm0JlfsBR06GTEuP_b9mjcjOJ4";

  static const assetsLocation = "assets\\audios\\";

  // image
  static const quranImage = "assets/icons/quran.png";
  static const dailyPrayerImage = "assets/icons/doaharian.png";
  static const favoriteImage = "assets/icons/favorite.png";
  static const hadistImage = "assets/icons/hadits.png";

  // v2
  static const prayIcon = "assets/icons/pray.png";
  static const shalatIcon = "assets/icons/shalat.png";
  static const allIcon = "assets/icons/select-all.png";
  static const mosqueIcon = "assets/icons/mosque.png";
  static const quranV2Icon = "assets/icons/quran_v2.png";
  static const readQuranIcon = "assets/icons/read_quran.png";
  static const prayingIcon = "assets/icons/praying.png";
  static const prayShalatIcon = "assets/icons/pray_shalat.png";
  static const qiblaIcon = "assets/icons/qibla.png";
  static const calculatorIcon = "assets/icons/calculator.png";
  static const bannerImage = "assets/images/banner_image.png";
  static const compassImage = "assets/images/compass.png";
  static const needleImage = "assets/images/needle.png";
  static const backgroundImage = "assets/images/background.png";
  static const frameCircleImage = "assets/images/frame_circle.png";

  static const colorBlackV2 = Color(0xFF323e2a);
  static const colorDeepGreenV2 = Color(0xFF677842);
  static const colorDeepYellowV2 = Color(0xFFd8b207);
  static const colorYellowV2 = Color(0xFFffd102);
  static const colorWhitekV2 = Color(0xFFedecf2);

  static const colorDeepBlackV2 = Color(0xFF152232);
  static const colorDeepBrownV2 = Color(0xFF253c2c);
  static const colorGreenV2 = Color(0xFF4c683f);
  static const colorlightGreenV2 = Color(0xFF7d9c72);
  static const colorLightBlueV2 = Color(0xFFc2d9df);
  static const colorRedV2 = Color(0xFFf96645);

  // end image

  static const urlImageNotFound = "https://demofree.sirv.com/nope-not-here.jpg";

  static List<Color> tagColors = [
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
  ];

  static const sizeBottomNav = 30.0;

  static const sizeTextTitle = 23.0;
  static const sizeSubTextTitle = 18.0;
  static const sizeText = 14.0;

  static const sizeTextArabian = 30.0;
  static const sizeTextArabianSub = 25.0;

  static var cornerRadiusBox = BorderRadius.circular(15.0);

  static BoxShadow boxShadowMenu = BoxShadow(
    color: Constants.color1.withOpacity(0.5),
    spreadRadius: 4,
    blurRadius: 10,
    offset: const Offset(0, 3), // changes position of shadow
  );

  static BoxShadow boxShadowMenuVersion2 = BoxShadow(
    color: Constants.color1.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 3,
    // offset: const Offset(0, 1), // changes position of shadow
  );

  static BoxShadow boxShadowMenuVersion3 = BoxShadow(
    color: Constants.iFebruaryInk1.withOpacity(1),
    spreadRadius: 1,
    blurRadius: 3,
    // offset: const Offset(0, 1), // changes position of shadow
  );

  static BoxShadow boxShadowMenuNewVersion = BoxShadow(
    color: Constants.color1.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 1,

    offset: const Offset(0, 2), // changes position of shadow
  );
}



// icon : <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by BZZRINCANTATION - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/pray" title="pray icons">Pray icons created by kerismaker - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/favorite" title="favorite icons">Favorite icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by zafdesign - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/dua" title="dua icons">Dua icons created by Siipkan Creative - Flaticon</a>


// icon new
// <a href="https://www.flaticon.com/free-icons/pray" title="pray icons">Pray icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/muslim" title="muslim icons">Muslim icons created by amonrat rungreangfangsai - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/pray" title="pray icons">Pray icons created by nawicon - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/ramadan" title="ramadan icons">Ramadan icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by Deylotus Creative Design - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/pray" title="pray icons">Pray icons created by Marz Gallery - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/select-all" title="select all icons">Select all icons created by bsd - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/qibla" title="qibla icons">Qibla icons created by Aranagraphics - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/calculator" title="calculator icons">Calculator icons created by Freepik - Flaticon</a>
// https://unsplash.com/photos/white-wall-paint-with-black-shadow-zGZYQQVmXw0?utm_content=creditShareLink&utm_medium=referral&utm_source=unsplash

///bingkai
///https://toppng.com/freepng/162901/round-frame-gold-clip-picture-frame#google_vignette