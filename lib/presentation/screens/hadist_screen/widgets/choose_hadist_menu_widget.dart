import 'package:flutter/material.dart';

import '../../../../blocs/export.dart';
import '../../../../utils/constants.dart';

class ChooseHadistMenuWidget extends StatefulWidget {
  bool isSpesifik;

  ChooseHadistMenuWidget({
    super.key,
    required this.isSpesifik,
  });

  @override
  State<ChooseHadistMenuWidget> createState() => _ChooseHadistMenuWidgetState();
}

class _ChooseHadistMenuWidgetState extends State<ChooseHadistMenuWidget> {
  int numSpesifik = 0;
  int numRange1 = 0;
  int numRange2 = 0;

  void resetNumber() {
    numRange1 = 0;
    numRange2 = 0;
    numSpesifik = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Constants.lightGreenColor, boxShadow: Constants.basicShadow),
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: (!widget.isSpesifik)
                    ? Constants.deepGreenColor
                    : Constants.whiteColor,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.sizeOf(context).height / 25,
                    width: MediaQuery.sizeOf(context).height / 25,
                    child: Image.asset(
                      Constants.specificIcon,
                      color: (!widget.isSpesifik)
                          ? Constants.whiteColor
                          : Constants.blackColor,
                    )),
                const SizedBox(height: 4),
                Text(
                  'Spesifik',
                  style: TextStyle(
                      color: (!widget.isSpesifik)
                          ? Constants.whiteColor
                          : Constants.blackColor,
                      fontSize: Constants.sizeSubTextTitle),
                ),
              ],
            ),
          ),
          Switch.adaptive(
              value: widget.isSpesifik,
              activeColor: Constants.deepGreenColor,
              onChanged: (values) {
                BlocProvider.of<HadistsBloc>(context)
                    .add(SelectedHadistEvent(isSpesifik: values));
                resetNumber();
              }),
          Container(
            decoration: BoxDecoration(
                color: (widget.isSpesifik)
                    ? Constants.deepGreenColor
                    : Constants.whiteColor,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.sizeOf(context).height / 25,
                    width: MediaQuery.sizeOf(context).height / 25,
                    child: Image.asset(
                      Constants.rangeIcon,
                      color: (widget.isSpesifik)
                          ? Constants.whiteColor
                          : Constants.blackColor,
                    )),
                const SizedBox(height: 4),
                Text(
                  'Range',
                  style: TextStyle(
                      color: (widget.isSpesifik)
                          ? Constants.whiteColor
                          : Constants.blackColor,
                      fontSize: Constants.sizeSubTextTitle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
