import 'package:flutter/material.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'package:kita_muslim/utils/number_utils.dart';

class IconNumberArabicWidget extends StatelessWidget {
  const IconNumberArabicWidget({
    super.key,
    required this.number,
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        Image.asset(Constants.frameCircleImage),
        Text(
          NumberUtils.convertToArabicNumber(number),
          style: const TextStyle(fontSize: Constants.sizeTextTitle),
        ),
      ],
    );
  }
}
