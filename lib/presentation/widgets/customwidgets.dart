import 'package:flutter/material.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../blocs/export.dart';

class CustomWidgets {
  /// new version 2
  static showLoadingIndicatorWithContainer(
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      height: height,
      width: width,
      color: Constants.greyColor,
      alignment: Alignment.center,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Constants.deepGreenColor),
        ),
      ),
    );
  }

  static showSnackBarCustom(
      BuildContext context, String description, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(description),
        backgroundColor:
            (isSuccess) ? Constants.deepGreenColor : Constants.redColor,
      ),
    );
  }

  ///

  static showDialogAppInfo(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "App Info",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height - 80,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            // color: Colors.white,
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.appWallpaper,
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  const Text("Email:"),
                  const Text(Constants.appDevEmail),
                  const SizedBox(height: 20),
                  const Text("Icon Credit:"),
                  const Text("https://www.flaticon.com/free-icons/"),
                  const SizedBox(height: 20),
                  const Text("Application Version:"),
                  const Text(Constants.appVersion),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  // static PreferredSizeWidget basicAppBar(String title, bool centerTitle=false,
  //     [List<Widget>? listAction] ) {
  //   return AppBar(
  //     title: Text(title),
  //     centerTitle: centerTitle,
  //     // backgroundColor: Constants.colorGreenDeep,
  //     backgroundColor: Constants.iwhite,
  //     actions: listAction,
  //   );
  // }

  static PreferredSizeWidget basicAppBar(BuildContext context, String title,
      {bool centerTitle = true,
      List<Widget>? listAction,
      bool needBackIcon = true,
      Function()? backIconFucntion}) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Constants.greyColor),
      ),
      centerTitle: centerTitle,
      actions: listAction,
      leading: (needBackIcon)
          ? IconButton(
              onPressed: (backIconFucntion == null)
                  ? () => Navigator.pop(context)
                  : backIconFucntion,
              icon: const Icon(Icons.arrow_back_ios_rounded),
            )
          : const SizedBox(),
    );
  }

  static Decoration decorationBasicUI() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Constants.deepGreenColor, Constants.whiteColor],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    );
  }

  static Divider standartDivider() {
    return const Divider(
      color: Constants.blackColor,
      height: 5,
    );
  }

  static showDialog1Button(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  static showDialogUnduhAudio(
      BuildContext context, String title, String content, int indexSurah) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<SurahBloc>(context)
                    .add(SendIndexSurah(indexSurah: indexSurah));
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 2
  static showDialog2Button(BuildContext context, String title, String content,
      @required Function() okButton,
      [String okButtonTitle = 'Unduh']) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: okButton,
              child: Text(okButtonTitle, style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  static showLoadingIcons(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            "Unduh",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: ListTile(
            title: Text(
              "Sedang Meng-unduh File...",
            ),
            trailing: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }

  static showLoadingVersion2(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 4,
            width: MediaQuery.sizeOf(context).width / 1.5,
            child: const Dialog(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 18),
                  Text("Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showCenterLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvoked: (didPop) => false,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            backgroundColor: Constants.blackColor,
            content: BlocBuilder<AudiomanagementBloc, AudiomanagementState>(
              builder: (context, state) {
                return const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(Constants.whiteColor),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  static showProgressDownload(BuildContext context, int progress, int total) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: const Text(
            "Status Unduh",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: ListTile(
            title: Text(
              "$progress ... $total",
            ),
            // trailing: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}
