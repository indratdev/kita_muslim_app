import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadist_menu_screen.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/hadits/hadists_model.dart';
import '../../../../utils/constants.dart';

class ListMasterHadistWidget extends StatelessWidget {
  final List<DataBooksHadists> data;

  const ListMasterHadistWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.sizeOf(context).height / 8,
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
                    builder: (context) =>
                        HadistMenuScreen(nameHadist: data[index].id),
                  ));
              BlocProvider.of<HadistsBloc>(context)
                  .add(SelectedHadistEvent(isSpesifik: false));
            },
            child: Container(
              margin:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              width: MediaQuery.of(context).size.width / 3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Constants.deepGreenColor,
                borderRadius: Constants.cornerRadiusBox,
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
}
