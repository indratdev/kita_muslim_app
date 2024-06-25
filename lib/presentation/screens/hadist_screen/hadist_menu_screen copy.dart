import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class HadistMenuScreen extends StatelessWidget {
  String nameHadist;

  int numSpesifik = 0;
  int numRange1 = 0;
  int numRange2 = 0;

  bool _isSpesifik = false;

  HadistMenuScreen({
    Key? key,
    required this.nameHadist,
  }) : super(key: key);

  void resetNumber() {
    numRange1 = 0;
    numRange2 = 0;
    numSpesifik = 0;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController numSpesifikController = TextEditingController();
    TextEditingController numRange1Controller = TextEditingController();
    TextEditingController numRange2Controller = TextEditingController();

    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        context,
        // "Hadis",
        nameHadist.toString(),
        backIconFunction: () {
          context.read<HadistsBloc>().add(GetListBookHadists());
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: <Widget>[
          BlocListener<HadistsBloc, HadistsState>(
            listener: (context, state) {},
            child: BlocBuilder<HadistsBloc, HadistsState>(
              builder: (context, state) {
                if (state is SuccessSelectedHadistSpesifikRange) {
                  _isSpesifik = state.result;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Spesifik',
                      style: TextStyle(fontSize: Constants.sizeSubTextTitle),
                    ),
                    Switch.adaptive(
                        value: _isSpesifik,
                        onChanged: (values) {
                          BlocProvider.of<HadistsBloc>(context)
                              .add(SelectedHadistEvent(isSpesifik: values));
                          resetNumber();
                        }),
                    const Text(
                      'Range',
                      style: TextStyle(fontSize: Constants.sizeSubTextTitle),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is SuccessSelectedHadistSpesifikRange) {
                return (!state.result)
                    ? Column(
                        children: <Widget>[
                          Column(
                            children: [
                              const Text("Nomer Hadis : "),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextField(
                                  controller: numSpesifikController,
                                  autocorrect: false,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<HadistsBloc>(context).add(
                                    GetSpesifikRangeHadistEvent(
                                        isSpesifik: _isSpesifik,
                                        numRange1: 0,
                                        numRange2: 0,
                                        numSpesifik: int.parse(
                                            numSpesifikController.text),
                                        nameHadist: nameHadist.toString()));
                                Navigator.pushNamed(context, '/hadistsSR');
                              },
                              child: const Text("Proses"),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Column(
                            children: [
                              Text("Nomer Hadis dari : "),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                      controller: numRange1Controller,
                                      keyboardType: TextInputType.number)),
                              SizedBox(height: 10),
                              Text("Ke -  :"),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                      controller: numRange2Controller,
                                      keyboardType: TextInputType.number)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<HadistsBloc>(context).add(
                                      GetSpesifikRangeHadistEvent(
                                          isSpesifik: _isSpesifik,
                                          numRange1: int.parse(
                                              numRange1Controller.text),
                                          numRange2: int.parse(
                                              numRange2Controller.text),
                                          numSpesifik: 0,
                                          nameHadist: nameHadist.toString()));
                                  Navigator.pushNamed(context, '/hadistsSR');
                                },
                                child: const Text("Proses")),
                          )
                        ],
                      );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class widgetOwner extends StatelessWidget {
  bool visibles;
  widgetOwner({Key? key, this.visibles = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!visibles)
        ? const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Nomer Hadist : "),
                TextField(keyboardType: TextInputType.number),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Nomer Hadist dari : "),
                TextField(keyboardType: TextInputType.number),
                Text("ke -  :"),
                TextField(keyboardType: TextInputType.number),
              ],
            ),
          );
  }
}
