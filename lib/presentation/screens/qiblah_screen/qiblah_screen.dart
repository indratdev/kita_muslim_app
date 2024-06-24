import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:kita_muslim/presentation/screens/qiblah_screen/widgets/loading_indicator_widget.dart';
import 'package:kita_muslim/presentation/screens/qiblah_screen/qiblah_compass.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  _QiblahScreenState createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomWidgets.basicAppBar(context, "Arah Kiblat", centerTitle: true),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const LoadingIndicatorWidget();
            return CustomWidgets.showLoadingIndicatorWithContainer(
                context,
                MediaQuery.sizeOf(context).height,
                MediaQuery.sizeOf(context).width - 50);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          }

          if (snapshot.data!) {
            return QiblahCompassWidget();
          } else {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).height / 2,
              child: const Center(
                child: Text("Error, Please try again!"),
              ),
            );
          }
        },
      ),
    );
  }
}
