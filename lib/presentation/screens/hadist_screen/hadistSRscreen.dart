import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadist_menu_screen.dart';

import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class HadistSRScreen extends StatelessWidget {
  String _nameHadist = "";
  HadistSRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // HadistMenuScreen(nameHadist: _nameHadist);
        // HadistMenuScreen(hadist:  ),
        BlocProvider.of<HadistsBloc>(context)
            .add(SelectedHadistEvent(isSpesifik: false));
        return true;
      },
      child: Scaffold(
        appBar: CustomWidgets.basicAppBar(
          context,
          "Hadis",
          backIconFunction: () {
            BlocProvider.of<HadistsBloc>(context)
                .add(SelectedHadistEvent(isSpesifik: false));
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              BlocBuilder<HadistsBloc, HadistsState>(
                builder: (context, state) {
                  if (state is LoadingSelectedHadistSpesifikRange) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }
                  if (state is FailureSelectedHadistSpesifikRange) {
                    return const Center(
                        child: Text("Error: Memuat Spesifik or Range Hadis"));
                  }
                  if (state is SuccessSpesifikRangeHadist) {
                    _nameHadist = state.nameHadist;
                    switch (state.isSpesifik) {
                      case false:
                        var result = state.spesifikModel;
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  // "HR. Nasai",
                                  result.data?.name ?? "",
                                  style: const TextStyle(
                                    fontSize: Constants.sizeTextTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  // "4996",
                                  result.data?.contents.number.toString() ?? "",
                                  style: const TextStyle(
                                    fontSize: Constants.sizeSubTextTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        // "أَخْبَرَنَا مُحَمَّدُ بْنُ بَشَّارٍ قَالَ حَدَّثَنَا عَبْدُ الرَّحْمَنِ عَنْ سُفْيَانَ عَنْ إِيَادِ بْنِ لَقِيطٍ عَنْ أَبِي رِمْثَةَ قَالَأَتَيْتُ أَنَا وَأَبِي النَّبِيَّ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ وَكَانَ قَدْ لَطَخَ لِحْيَتَهُ بِالْحِنَّاءِ",
                                        result.data?.contents.arab.toString() ??
                                            "",
                                    style: const TextStyle(
                                      fontSize: Constants.sizeTextArabianSub,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text:
                                        // "Telah mengkhabarkan kepada kami [Muhammad bin Basysyar], dia berkata; telah menceritakan kepada kami [Abdur Rahman] dari [Sufyan] dari [Iyad bin Laqith] dari [Abu Rimtsah], dia berkata; Aku bersama ayahku menemui Nabi shallallahu 'alaihi wasallam ketika itu beliau melumuri jenggot beliau dengan inai.",
                                        result.data?.contents.id.toString() ??
                                            "",
                                    style: const TextStyle(
                                      fontSize: Constants.sizeSubTextTitle,
                                      color: Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      case true:
                        var result = state.rangeModel;
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
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Hadis Nomer:  ${result.data?.hadiths[index].number.toString() ?? ""} ",
                                            style: TextStyle(
                                              fontSize:
                                                  Constants.sizeSubTextTitle,
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: result
                                                    .data?.hadiths[index].arab
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                              fontSize:
                                                  Constants.sizeTextArabianSub,
                                              color: Constants.deepGreenColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                            text: result.data?.hadiths[index].id
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                              fontSize:
                                                  Constants.sizeSubTextTitle,
                                              color: Constants.blackColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );

                      default:
                        return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
