import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/home_screen/widgets/next_time_duration_widget.dart';

import '../../../../utils/constants.dart';

class InfoBannerWidget extends StatelessWidget {
  const InfoBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      left: 10,
      bottom: 3,
      child: Container(
        height: MediaQuery.sizeOf(context).height / 7,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage(Constants.bannerImage),
              fit: BoxFit.fitWidth,
            )),
        child:
            // Center(child: CircularProgressIndicator.adaptive(),),
            BlocBuilder<PrayerBloc, PrayerState>(
          builder: (context, state) {
            if (state is LoadingNextPrayerTime) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is FailureNextPrayerTime) {
              return const Center(
                child: Text("Failed to load data"),
              );
            }

            if (state is SuccessNextPrayerTime) {
              Map<String, dynamic> datas = state.result;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Menjelang waktu Solat ',
                        children: <TextSpan>[
                          TextSpan(
                            text: datas['description'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.sizeOf(context).width / 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${datas["next_times"]} ",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.sizeOf(context).width / 15),
                    ),
                    NextTimeDurationWidget(
                      datas: datas,
                      currentTimeString: datas['current_times'],
                      targetTimeeString: datas['next_times'],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Failed to load data"),
              );
            }
          },
        ),
      ),
    );
  }
}
