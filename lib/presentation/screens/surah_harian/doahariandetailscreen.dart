import 'package:flutter/material.dart';
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class DoaHarianDetailScreen extends StatelessWidget {
  late SurahHarianModel result;
  int _indexSurah = 0;

  DoaHarianDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SurahBloc>(context).add(GetAllSurahHarian(_indexSurah));

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomWidgets.basicAppBar("Surat Harian"),
          body: BlocConsumer<SurahBloc, SurahState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LoadingDoaHarianDetail) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is FailureDoaHarianDetail) {
                return Center(child: Text(state.errorMessage.toString()));
              }

              if (state is SuccessSendDoaHarianDetailState) {
                result = state.surah;
                _indexSurah = state.indexSurah;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 15, right: 15, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        // judul
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: [Constants.boxShadowMenu],
                              color: Constants.whiteColor,
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              result.doa,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: Constants.sizeTextTitle,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // ayat
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15, bottom: 5),
                          child: Text(
                            result.ayat,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: Constants.sizeTextArabian,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // latin
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 5, right: 5, bottom: 5),
                          child: Text(
                            result.latin,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Constants.greenColor,
                                fontSize: Constants.sizeTextTitle),
                          ),
                        ),

                        // arti
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 5, right: 5, bottom: 5),
                          child: Text(
                            result.artinya,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: Constants.sizeSubTextTitle,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
