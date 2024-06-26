import 'package:flutter/material.dart';
import 'package:kita_muslim/config/routes.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/hadits/hadists_model.dart';
import '../../../../utils/constants.dart';

class SpesifikMenuWidget extends StatelessWidget {
  TextEditingController numSpesifikController;
  bool isSpesifik;
  DataBooksHadists? dataBook;

  SpesifikMenuWidget({
    super.key,
    required this.numSpesifikController,
    required this.isSpesifik,
    this.dataBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Masukan Nomer Hadist : ",
              style: TextStyle(fontSize: Constants.sizeSubTextTitle),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                controller: numSpesifikController,
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
        const SizedBox(height: 14),
        SizedBox(
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
                      numRange1: 0,
                      numRange2: 0,
                      numSpesifik: int.parse(numSpesifikController.text),
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
