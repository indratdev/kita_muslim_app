import 'package:flutter/material.dart';

import '../../../../data/models/hadits/hadistsR_model.dart';
import '../../../../utils/constants.dart';

class ResultSpesifikWidget extends StatelessWidget {
  final HadistsRModel result;

  const ResultSpesifikWidget({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Constants.lightGreenColor,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height / 12,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    result.data?.name ?? "",
                    style: const TextStyle(
                      fontSize: Constants.sizeTextTitle,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " No. Hadis ${result.data?.contents.number.toString()} ",
                    style: const TextStyle(
                      fontSize: Constants.sizeText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 21),
            RichText(
              softWrap: true,
              textAlign: TextAlign.right,
              text: TextSpan(
                text: result.data?.contents.arab.toString() ?? "",
                style: const TextStyle(
                  fontSize: Constants.sizeTextArabianSub,
                  color: Constants.blackColor,
                ),
              ),
            ),
            const SizedBox(height: 21),
            RichText(
              softWrap: true,
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: result.data?.contents.id
                        .toString()
                        .split('.')
                        .join('.\n') ??
                    "",
                style: const TextStyle(
                  fontSize: Constants.sizeSubTextTitle,
                  color: Constants.deepGreenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
