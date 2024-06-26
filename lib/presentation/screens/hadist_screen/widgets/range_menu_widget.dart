import 'package:flutter/material.dart';

import '../../../../blocs/export.dart';
import '../../../../config/routes.dart';
import '../../../../data/models/hadits/hadists_model.dart';
import '../../../../utils/constants.dart';

class RangeMenuWidget extends StatelessWidget {
  TextEditingController numRange1Controller;
  TextEditingController numRange2Controller;
  bool isSpesifik;
  DataBooksHadists? dataBook;

  RangeMenuWidget({
    super.key,
    required this.numRange1Controller,
    required this.numRange2Controller,
    required this.isSpesifik,
    this.dataBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  "No. Hadist \ndari : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Constants.sizeSubTextTitle),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    controller: numRange1Controller,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 12,
                      fontWeight: FontWeight.w500,
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Icon(Icons.double_arrow_rounded),
            ),
            Column(
              children: [
                const Text(
                  "No. Hadist \nsampai : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Constants.sizeSubTextTitle),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height / 16,
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    controller: numRange2Controller,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width / 12,
                      fontWeight: FontWeight.w500,
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 36),
          width: MediaQuery.sizeOf(context).width / 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Constants.deepGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            onPressed: () async {
              BlocProvider.of<HadistsBloc>(context).add(
                  GetSpesifikRangeHadistEvent(
                      isSpesifik: isSpesifik,
                      numRange1: int.parse(numRange1Controller.text),
                      numRange2: int.parse(numRange2Controller.text),
                      numSpesifik: 1,
                      nameHadist: dataBook?.id.toString() ?? ""));

              Navigator.pushNamed(context, Routes.hadistResultScreen);
            },
            child: const Text(
              "Proses",
              style: TextStyle(color: Constants.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
