import 'package:flutter/material.dart';
import 'package:kita_muslim/utils/constants.dart';

class HomeWidgets {
  static showHomeMenuItem(String iconName, String menuName) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Constants.whiteColor,
        borderRadius: Constants.cornerRadiusBox, //BorderRadius.circular(15),
        boxShadow: [Constants.boxShadowMenu],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Tab(
            icon: Image.asset(
              iconName,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            menuName,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
