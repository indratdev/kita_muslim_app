import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import '../../../blocs/export.dart';
import '../../../data/models/hadits/hadists_model.dart';
import 'widgets/export.dart';

class HadistMenuScreen extends StatelessWidget {
  DataBooksHadists? dataBook;

  bool _isSpesifik = false;

  HadistMenuScreen({
    Key? key,
    this.dataBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController numSpesifikController = TextEditingController();
    TextEditingController numRange1Controller = TextEditingController();
    TextEditingController numRange2Controller = TextEditingController();

    resetController() {
      numSpesifikController.text = "";
      numRange1Controller.text = "";
      numRange2Controller.text = "";
    }

    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        context,
        dataBook?.name.toString() ?? "",
        backIconFunction: () {
          context.read<HadistsBloc>().add(GetListBookHadists());
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: <Widget>[
          BlocListener<HadistsBloc, HadistsState>(
            listener: (context, state) {
              if (state is SuccessSelectedHadistSpesifikRange) {
                _isSpesifik = state.result;
                resetController();
              }
            },
            child: BlocBuilder<HadistsBloc, HadistsState>(
              builder: (context, state) {
                return ChooseHadistMenuWidget(isSpesifik: _isSpesifik);
              },
            ),
          ),
          const SizedBox(height: 36),
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is SuccessSelectedHadistSpesifikRange) {
                return (!state.result)
                    ? SpesifikMenuWidget(
                        numSpesifikController: numSpesifikController,
                        isSpesifik: _isSpesifik,
                        dataBook: dataBook,
                      )
                    : RangeMenuWidget(
                        numRange1Controller: numRange1Controller,
                        numRange2Controller: numRange2Controller,
                        isSpesifik: _isSpesifik,
                        dataBook: dataBook,
                      );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
