import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadistdetailscreen.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class HadistScreen extends StatelessWidget {
  const HadistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar("Hadis"),
      body: Column(
        children: <Widget>[
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is LoadingHadistsBooks) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: const CircularProgressIndicator.adaptive(),
                );
              }

              if (state is FailureHadistsBooks) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: Text(state.message.toString()),
                );
              }

              if (state is SuccessHadistsBooks) {
                var data = state.result.data;
                return Container(
                  margin: const EdgeInsets.all(10),
                  // color: Colors.blue,
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HadistDetailScreen(
                                    nameHadist: data[index].id),
                              ));
                          BlocProvider.of<HadistsBloc>(context)
                              .add(SelectedHadistEvent(isSpesifik: false));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Constants.deepGreenColor,
                            borderRadius: Constants
                                .cornerRadiusBox, //BorderRadius.circular(15),
                            boxShadow: [Constants.boxShadowMenuVersion2],
                          ),
                          child: ListTile(
                            title: Text(
                              data[index].name.toString(),
                              style: const TextStyle(
                                color: Constants.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${data[index].available.toString()} Hadis",
                              style: const TextStyle(
                                color: Constants.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return Container();
            },
          ),
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is SuccessHadistsBooks) {
                var resulRandom = state.resultRandom.data;
                return Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10, bottom: 0),
                      decoration: const BoxDecoration(
                          color: Constants.whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
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
                                resulRandom!.name.toString(),
                                style: const TextStyle(
                                  fontSize: Constants.sizeTextTitle,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                resulRandom.contents.number.toString(),
                                style: const TextStyle(
                                  fontSize: Constants.sizeSubTextTitle,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: resulRandom.contents.arab.toString(),
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
                                text: resulRandom.contents.id.toString(),
                                style: const TextStyle(
                                  fontSize: Constants.sizeSubTextTitle,
                                  color: Constants.blackColor,
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
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
