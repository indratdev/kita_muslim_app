import 'package:flutter/material.dart';

import '../../../../data/models/hadits/hadistsR_model.dart';
import '../../../../utils/constants.dart';

class DetailHadistWidget extends StatelessWidget {
  final Data data;

  const DetailHadistWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          decoration: const BoxDecoration(
              color: Constants.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "**Hadis Hari Ini",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: Constants.sizeSubTextTitle,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    data.name.toString(),
                    style: const TextStyle(
                      fontSize: Constants.sizeTextTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    data.contents.number.toString(),
                    style: const TextStyle(
                      fontSize: Constants.sizeSubTextTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  softWrap: true,
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: data.contents.arab.toString(),
                    style: const TextStyle(
                      fontSize: Constants.sizeTextArabianSub,
                      color: Constants.blackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: data.contents.id.toString(),
                    style: const TextStyle(
                      fontSize: Constants.sizeSubTextTitle,
                      color: Constants.deepGreenColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
