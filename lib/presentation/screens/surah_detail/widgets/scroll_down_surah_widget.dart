import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../utils/constants.dart';

class ScrollDownSurahWidget extends StatefulWidget {
  final ItemScrollController itemScrollController;
  bool isScrolling;
  final int numberOfVerse;

  ScrollDownSurahWidget({
    super.key,
    required this.isScrolling,
    required this.itemScrollController,
    required this.numberOfVerse,
  });

  @override
  State<ScrollDownSurahWidget> createState() => _ScrollDownSurahWidgetState();
}

class _ScrollDownSurahWidgetState extends State<ScrollDownSurahWidget> {
  bool stopScrolling = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const StadiumBorder(side: BorderSide.none),
      elevation: 5,
      tooltip: 'Move Down',
      backgroundColor: Constants.colorlightGreenV2,
      child: (widget.isScrolling)
          ? const Icon(Icons.stop)
          : const Icon(Icons.keyboard_double_arrow_down_sharp),
      onPressed: () async {
        if (widget.isScrolling) {
          setState(() {
            stopScrolling = true;
            widget.isScrolling = false;
          });
        } else {
          setState(() {
            stopScrolling = false;
            widget.isScrolling = true;
          });

          for (int i = currentIndex; i <= widget.numberOfVerse - 1; i++) {
            if (stopScrolling) break;
            await Future.delayed(const Duration(seconds: 5));
            widget.itemScrollController.scrollTo(
              index: i,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubic,
            );
            currentIndex = i + 1;
          }

          if (!stopScrolling) {
            setState(() {
              widget.isScrolling = false;
            });
          }
        }
      },
    );
  }
}
