import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kita_muslim/data/services/location_services.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/info_banner_widget.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/main_menu_widget.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/news_menu_widget.dart';

import '../../../data/others/menu_controller.dart';
import '../../../utils/constants.dart';
import '../../widgets/customwidgets.dart';

class HomeScreenV2 extends StatelessWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        Constants.appName,
        <Widget>[
          IconButton(
            onPressed: () {
              CustomWidgets.showDialogAppInfo(context);
            },
            icon: const Icon(Icons.info),
          ),
          IconButton(
            onPressed: ()  {
              print("press");
              LocationService().getLocationNameByCoordinate();
              
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.sizeOf(context).height / 2.8,
                child: SizedBox(
                  child: Image.network(
                    "https://gratisography.com/wp-content/uploads/2024/03/gratisography-funflower-800x525.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InfoBannerWidget(),
            ],
          ),

          // 2
          MainMenuWidget(),
          NewsMenuWidget()
        ],
      ),
    );
  }
}
