
import 'package:flutter/material.dart';

import '../../../../data/others/menu_controller.dart';
import '../../../../utils/constants.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Constants.color3,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
          mainAxisExtent: MediaQuery.sizeOf(context).width / 5,
        ),
        padding: const EdgeInsets.all(8.0), // padding around the grid
        itemCount: MenusController().getListmenuPacket.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          MenuModel data = MenusController().getListmenuPacket[index];
          return InkWell(
            onTap: () {
              if (data.menuRoute != null) {
                data.menuRoute!(context); // Pass context here
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  child: Image.asset(
                    data.menuIcon,
                    // Constants.appWallpaper,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Text(
                  // menusController.getListmenuPacket[index].menuName,
                  data.menuName,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
