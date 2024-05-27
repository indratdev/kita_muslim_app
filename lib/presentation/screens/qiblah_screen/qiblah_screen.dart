import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:kita_muslim/presentation/screens/qiblah_screen/widgets/loading_indicator_widget.dart';
import 'package:kita_muslim/presentation/screens/qiblah_screen/qiblah_compass.dart';

class QiblahScreen extends StatefulWidget {
  @override
  _QiblahScreenState createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arah Kiblat'),
      ),
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicatorWidget();
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


// MaterialApp(
//       theme: ThemeData(
//         primaryColor: const Color(0xff0c7b93),
//         primaryColorLight: const Color(0xff00a8cc),
//         primaryColorDark: const Color(0xff27496d),
//         colorScheme: ColorScheme.fromSwatch()
//             .copyWith(secondary: const Color(0xffecce6d)),
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//           colorScheme: ColorScheme.fromSwatch()
//               .copyWith(secondary: const Color(0xffecce6d))),

/*class CenterEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FlatButton(
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Example();
                  },
                ),
              );
            },
            child: Text('Open Qiplah'),
          ),
        ));
  }
}*/


// class CenterEx extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: RaisedButton(
//             color: Theme.of(context).accentColor,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return Scaffold(
//                       appBar: AppBar(
//                         title: Text("Compass"),
//                       ),
//                       body: TestingCompassWidget(),
//                     );
//                   },
//                 ),
//               );
//             },
//             child: Text('Open Compass'),
//           ),
//         ));
//   }
// }
//
// class TestingCompassWidget extends StatefulWidget {
//   @override
//   _TestingCompassWidgetState createState() => _TestingCompassWidgetState();
// }
//
// class _TestingCompassWidgetState extends State<TestingCompassWidget> {
//   @override
//   void dispose() {
//     FlutterCompass().dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _buildManualReader(),
//     );
//   }
//
//   Widget _buildManualReader() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: StreamBuilder<double>(
//           stream: FlutterCompass.events,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('Error reading heading: ${snapshot.error}');
//             }
//
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//             double direction = snapshot.data;
//             return Text(
//               '$direction',
//               style: Theme.of(context).textTheme.button,
//             );
//           }),
//     );
//   }
// }
