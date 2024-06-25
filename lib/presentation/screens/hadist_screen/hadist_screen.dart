import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import '../../../blocs/export.dart';
import '../../../data/models/hadits/hadistsR_model.dart';
import '../../../data/models/hadits/hadists_model.dart';
import 'widgets/export.dart';

class HadistScreen extends StatelessWidget {
  const HadistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(context, "Hadis"),
      body: Column(
        children: <Widget>[
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is LoadingHadistsBooks) {
                return CustomWidgets.showLoadingIndicatorWithContainer(
                    context,
                    MediaQuery.sizeOf(context).height / 8,
                    MediaQuery.sizeOf(context).width);
              }

              if (state is FailureHadistsBooks) {
                return Container(
                  height: MediaQuery.sizeOf(context).height / 8,
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: Text(state.message.toString()),
                );
              }

              if (state is SuccessHadistsBooks) {
                List<DataBooksHadists> data = state.result.data;
                return ListMasterHadistWidget(data: data);
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is LoadingHadistsBooks) {
                return Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: CustomWidgets.showLoadingIndicatorWithContainer(
                      context,
                      MediaQuery.sizeOf(context).height / 1.4,
                      MediaQuery.sizeOf(context).width),
                );
              }

              if (state is SuccessHadistsBooks) {
                Data? resultRandom = state.resultRandom.data;
                return DetailHadistWidget(
                  data: resultRandom!,
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
