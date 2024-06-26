import 'package:flutter/material.dart';

import '../../../../data/models/hadits/hadistRange_model.dart';
import '../../../../utils/constants.dart';

class ResultRangeWidget extends StatelessWidget {
  final HadistRangeModel result;

  const ResultRangeWidget({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            result.data?.name.toString() ?? "",
            style: const TextStyle(
              fontSize: Constants.sizeTextTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: result.data?.hadiths.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hadis No.  ${result.data?.hadiths[index].number.toString() ?? ""} ",
                          style: const TextStyle(
                            fontSize: Constants.sizeSubTextTitle,
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      softWrap: true,
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: result.data?.hadiths[index].arab.toString() ?? "",
                        style: const TextStyle(
                          fontSize: Constants.sizeTextArabianSub,
                          color: Constants.blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    RichText(
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: result.data?.hadiths[index].id
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
