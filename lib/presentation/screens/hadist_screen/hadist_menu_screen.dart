import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/presentation/widgets/textformfied_custom.dart';
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
                return Container(
                  margin: const EdgeInsets.only(top: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: (!_isSpesifik)
                                ? Constants.deepGreenColor
                                : Constants.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.sizeOf(context).height / 25,
                                width: MediaQuery.sizeOf(context).height / 25,
                                child: Image.asset(
                                  Constants.specificIcon,
                                  color: (!_isSpesifik)
                                      ? Constants.whiteColor
                                      : Constants.blackColor,
                                )),
                            const SizedBox(height: 4),
                            Text(
                              'Spesifik',
                              style: TextStyle(
                                  color: (!_isSpesifik)
                                      ? Constants.whiteColor
                                      : Constants.blackColor,
                                  fontSize: Constants.sizeSubTextTitle),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                          value: _isSpesifik,
                          activeColor: Constants.deepGreenColor,
                          onChanged: (values) {
                            BlocProvider.of<HadistsBloc>(context)
                                .add(SelectedHadistEvent(isSpesifik: values));
                            resetNumber();
                          }),
                      Container(
                        decoration: BoxDecoration(
                            color: (_isSpesifik)
                                ? Constants.deepGreenColor
                                : Constants.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(14),
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.sizeOf(context).height / 25,
                                width: MediaQuery.sizeOf(context).height / 25,
                                child: Image.asset(
                                  Constants.rangeIcon,
                                  color: (_isSpesifik)
                                      ? Constants.whiteColor
                                      : Constants.blackColor,
                                )),
                            const SizedBox(height: 4),
                            Text(
                              'Range',
                              style: TextStyle(
                                  color: (_isSpesifik)
                                      ? Constants.whiteColor
                                      : Constants.blackColor,
                                  fontSize: Constants.sizeSubTextTitle),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 36),
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is SuccessSelectedHadistSpesifikRange) {
                return (!state.result)
                    ? Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Masukan Nomer Hadist : ",
                                  style: TextStyle(
                                      fontSize: Constants.sizeSubTextTitle),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: TextField(
                                    controller: numSpesifikController,
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       BlocProvider.of<HadistsBloc>(context).add(
                          //           GetSpesifikRangeHadistEvent(
                          //               isSpesifik: _isSpesifik,
                          //               numRange1: 0,
                          //               numRange2: 0,
                          //               numSpesifik: int.parse(
                          //                   numSpesifikController.text),
                          //               nameHadist: nameHadist.toString()));
                          //       Navigator.pushNamed(context, '/hadistsSR');
                          //     },
                          //     child: const Text("Proses"),
                          //   ),
                          // )
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
                                        isSpesifik: _isSpesifik,
                                        numRange1: 0,
                                        numRange2: 0,
                                        numSpesifik: int.parse(
                                            numSpesifikController.text),
                                        nameHadist: nameHadist.toString()));
                                Navigator.pushNamed(context, '/hadistsSR');
                              },
                              child: const Text(
                                "Proses",
                                style: TextStyle(color: Constants.whiteColor),
                              ),
                            ),
                          ),
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
