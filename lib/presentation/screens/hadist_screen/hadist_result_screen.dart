import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import '../../../blocs/export.dart';
import '../../../data/models/hadits/hadistRange_model.dart';
import '../../../data/models/hadits/hadistsR_model.dart';
import 'widgets/export.dart';

class HadistResultScreen extends StatelessWidget {
  String nameHadist = "";

  HadistResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSpecifik = false;

    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        context,
        "Hadis",
        backIconFunction: () {
          BlocProvider.of<HadistsBloc>(context)
              .add(SelectedHadistEvent(isSpesifik: isSpecifik));
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            BlocBuilder<HadistsBloc, HadistsState>(
              builder: (context, state) {
                if (state is LoadingSelectedHadistSpesifikRange) {
                  return CustomWidgets.showLoadingIndicatorWithContainer(
                      context,
                      MediaQuery.sizeOf(context).height,
                      MediaQuery.sizeOf(context).width - 100);
                }
                if (state is FailureSelectedHadistSpesifikRange) {
                  return const Center(
                      child: Text("Gagal Memuat Spesifik atau Range Hadis"));
                }
                if (state is SuccessSpesifikRangeHadist) {
                  nameHadist = state.nameHadist;
                  isSpecifik = state.isSpesifik;
                  switch (state.isSpesifik) {
                    case false:
                      HadistsRModel result = state.spesifikModel;
                      return ResultSpesifikWidget(result: result);

                    case true:
                      HadistRangeModel result = state.rangeModel;
                      return ResultRangeWidget(result: result);

                    default:
                      return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
